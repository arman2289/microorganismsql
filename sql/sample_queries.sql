```sql
-- Enhanced Microorganisms Database - Sample Analytical Queries
-- Developer: [arman shaikh]
-- Date: december 2024

-- =========================================================================
-- Query 1: Find bacteria with antibiotic resistance profiles
-- =========================================================================
-- Purpose: Identify bacteria that have developed resistance to antibiotics,
-- which is a major public health concern
-- =========================================================================

SELECT 
    b.scientific_name, 
    b.common_name,
    t.phylum,
    t.family,
    b.gram_stain,
    b.antibiotic_resistance
FROM 
    Bacteria b
JOIN 
    Taxonomy t ON b.taxonomy_id = t.taxonomy_id
WHERE 
    b.antibiotic_resistance IS NOT NULL
    AND b.antibiotic_resistance != ''
ORDER BY 
    t.phylum, t.family, b.scientific_name;

-- =========================================================================
-- Query 2: Analyze microorganism distribution across habitats
-- =========================================================================
-- Purpose: Understand biodiversity patterns and which microorganisms
-- coexist in the same environments
-- =========================================================================

SELECT 
    h.habitat_name,
    COUNT(DISTINCT bh.bacteria_id) as bacteria_count,
    COUNT(DISTINCT fh.fungi_id) as fungi_count,
    COUNT(DISTINCT ph.protozoa_id) as protozoa_count,
    COUNT(DISTINCT ch.cyanobacteria_id) as cyanobacteria_count,
    COUNT(DISTINCT plh.plankton_id) as plankton_count
FROM 
    Habitats h
LEFT JOIN 
    Bacteria_Habitats bh ON h.habitat_id = bh.habitat_id
LEFT JOIN 
    Fungi_Habitats fh ON h.habitat_id = fh.habitat_id
LEFT JOIN 
    Protozoa_Habitats ph ON h.habitat_id = ph.habitat_id
LEFT JOIN 
    Cyanobacteria_Habitats ch ON h.habitat_id = ch.habitat_id
LEFT JOIN 
    Plankton_Habitats plh ON h.habitat_id = plh.habitat_id
GROUP BY 
    h.habitat_name
ORDER BY 
    (bacteria_count + fungi_count + protozoa_count + cyanobacteria_count + plankton_count) DESC;

-- =========================================================================
-- Query 3: Find all microorganisms with medicinal applications
-- =========================================================================
-- Purpose: Identify microorganisms that have applications in medicine,
-- including pharmaceuticals and treatments
-- =========================================================================

SELECT 
    'Bacteria' as organism_type, 
    b.scientific_name, 
    ma.application_name, 
    ma.development_stage
FROM 
    Bacteria b
JOIN 
    Bacteria_Medical_Applications bma ON b.bacteria_id = bma.bacteria_id
JOIN 
    Medical_Applications ma ON bma.application_id = ma.application_id

UNION

SELECT 
    'Fungi' as organism_type, 
    f.scientific_name, 
    ma.application_name, 
    ma.development_stage
FROM 
    Fungi f
JOIN 
    Fungi_Medical_Applications fma ON f.fungi_id = fma.fungi_id
JOIN 
    Medical_Applications ma ON fma.application_id = ma.application_id

ORDER BY 
    application_name, organism_type;

-- =========================================================================
-- Query 4: Analyze pathogens and their disease relationships
-- =========================================================================
-- Purpose: Examine which microorganisms cause specific diseases and their
-- transmission methods
-- =========================================================================

SELECT 
    d.disease_name,
    CASE 
        WHEN md.microorganism_type = 'Bacteria' THEN b.scientific_name
        WHEN md.microorganism_type = 'Fungi' THEN f.scientific_name
        WHEN md.microorganism_type = 'Protozoa' THEN p.scientific_name
    END AS causative_agent,
    md.microorganism_type,
    md.role_in_disease,
    d.transmission_method,
    d.mortality_rate
FROM 
    Diseases d
JOIN 
    Microorganism_Diseases md ON d.disease_id = md.disease_id
LEFT JOIN 
    Bacteria b ON md.microorganism_type = 'Bacteria' AND md.microorganism_id = b.bacteria_id
LEFT JOIN 
    Fungi f ON md.microorganism_type = 'Fungi' AND md.microorganism_id = f.fungi_id
LEFT JOIN 
    Protozoa p ON md.microorganism_type = 'Protozoa' AND md.microorganism_id = p.protozoa_id
ORDER BY 
    d.disease_name, md.role_in_disease;

-- =========================================================================
-- Query 5: Find related microorganisms by taxonomic classification
-- =========================================================================
-- Purpose: Explore evolutionary relationships between microorganisms by
-- analyzing their taxonomic classifications
-- =========================================================================

SELECT 
    t.phylum,
    t.class,
    t.family,
    COUNT(DISTINCT b.bacteria_id) as bacteria_count,
    COUNT(DISTINCT f.fungi_id) as fungi_count,
    COUNT(DISTINCT p.protozoa_id) as protozoa_count,
    GROUP_CONCAT(DISTINCT CASE WHEN b.bacteria_id IS NOT NULL THEN b.scientific_name END) as bacteria_examples,
    GROUP_CONCAT(DISTINCT CASE WHEN f.fungi_id IS NOT NULL THEN f.scientific_name END) as fungi_examples,
    GROUP_CONCAT(DISTINCT CASE WHEN p.protozoa_id IS NOT NULL THEN p.scientific_name END) as protozoa_examples
FROM 
    Taxonomy t
LEFT JOIN 
    Bacteria b ON t.taxonomy_id = b.taxonomy_id
LEFT JOIN 
    Fungi f ON t.taxonomy_id = f.taxonomy_id
LEFT JOIN 
    Protozoa p ON t.taxonomy_id = p.taxonomy_id
GROUP BY 
    t.phylum, t.class, t.family
HAVING 
    bacteria_count + fungi_count + protozoa_count > 0
ORDER BY 
    t.phylum, t.class, t.family;

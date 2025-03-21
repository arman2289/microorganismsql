# Enhanced Microorganisms Database Project

**Developer:** arman  
**Date:** december 2024

## Project Overview

I designed and implemented a comprehensive relational database system to catalog, classify, and analyze microorganisms including bacteria, fungi, protozoa, cyanobacteria, and plankton. This database serves as a scientific information repository that demonstrates the complex relationships between microorganisms, their habitats, applications, and ecological roles.
## Statement of Originality

This Enhanced Microorganisms Database is my original work. While I referenced scientific literature for biological accuracy and SQL documentation for syntax guidance, the database architecture, relationship design, and implementation are entirely my own. This project demonstrates my understanding of both relational database principles and microbiology concepts.

## Personal Context

My fascination with microorganisms began in high school when I first viewed pond water under a microscope. Living in a coastal region, I've witnessed harmful algal blooms firsthand, which sparked my interest in cyanobacteria and plankton. The COVID-19 pandemic further deepened my interest in microbiology. This project bridges my dual passions for computer science and biology, allowing me to create a comprehensive system that catalogs the diversity and importance of microorganisms in both ecological systems and human applications.

## Database Design Philosophy

This project represents a significant enhancement of a basic microorganisms database. My approach focused on:

1. **Scientific Accuracy** - Incorporating detailed taxonomic classification and biological characteristics
2. **Relational Structure** - Creating proper relationships between entities to eliminate redundancy
3. **Data Completeness** - Adding comprehensive metadata for each microorganism
4. **Research Support** - Designing the schema to support scientific queries and analysis
5. **Educational Value** - Organizing information to facilitate learning about microbiology

## Database Structure

### Core Entity Tables
The database includes specialized tables for different microorganism types:

* **Bacteria** - 13 species with detailed morphological and physiological characteristics
* **Fungi** - 12 species including yeasts, molds, and mushrooms
* **Protozoa** - 8 species representing various protist groups
* **Cyanobacteria** - 5 species of photosynthetic bacteria
* **Plankton** - 5 species of aquatic microorganisms

### Classification and Taxonomy
* **Taxonomy** - Standardized hierarchical classification (domain through genus)
* **Researchers** - Notable scientists who discovered or study microorganisms

### Environmental Context
* **Habitats** - 19 diverse environments where microorganisms are found
* **Habitat Relationship Tables** - Many-to-many connections showing where each organism lives

### Applications and Implications
* **Medical Applications** - 10 healthcare uses of microorganisms
* **Industrial Applications** - 10 commercial and industrial uses
* **Diseases** - Conditions caused by pathogenic microorganisms
* **Enzymes** - Biocatalysts produced by microorganisms

### Scientific Data
* **Genetic Sequences** - Genomic data with metadata about sequencing
* **Antimicrobial Compounds** - Natural products with medicinal applications
* **Research Studies** - Scientific investigations of microorganisms

## Schema Diagram

The database uses a complex relational structure with over 30 tables. Key relationships include:
## Sample Data Highlights

### Bacteria Examples
* **Escherichia coli** - Common gut bacterium, model organism in microbiology
* **Mycobacterium tuberculosis** - Causative agent of tuberculosis
* **Helicobacter pylori** - Stomach bacterium that causes ulcers
* **Pseudomonas aeruginosa** - Versatile pathogen with antibiotic resistance

### Fungi Examples
* **Saccharomyces cerevisiae** - Baker's yeast used in food production
* **Penicillium notatum** - Source of penicillin antibiotic
* **Candida albicans** - Opportunistic human pathogen
* **Ganoderma lucidum** - Medicinal mushroom with bioactive compounds

### Protozoa Examples
* **Plasmodium falciparum** - Causative agent of malaria
* **Trypanosoma brucei** - Causes sleeping sickness
* **Entamoeba histolytica** - Causes amoebic dysentery

### Cyanobacteria Examples
* **Anabaena** - Nitrogen-fixing filamentous cyanobacterium
* **Microcystis** - Forms toxic harmful algal blooms

### Plankton Examples
* **Emiliania huxleyi** - Important calcium carbonate producer
* **Alexandrium fundyense** - Causes toxic red tides

## Advanced Features

### 1. Taxonomic Classification System
The database implements a complete taxonomic hierarchy from domain to genus, enabling precise scientific classification and phylogenetic queries.

### 2. Many-to-Many Relationship Mapping
Complex relationships are properly modeled with junction tables, including:
* Organisms to habitats
* Organisms to applications (medical and industrial)
* Organisms to diseases
* Organisms to enzymes produced

### 3. Scientific Metadata
Each organism includes detailed scientific characteristics:
* Morphological features
* Optimal growth conditions
* Genome size
* Pathogenicity information
* Resistance profiles

### 4. Domain-Specific Attributes
Each microorganism type has specialized attributes relevant to its biology:
* **Bacteria**: Gram stain, cell morphology, antibiotic resistance
* **Fungi**: Reproductive structures, mycelium characteristics
* **Protozoa**: Locomotion method, lifecycle stages
* **Cyanobacteria**: Nitrogen fixation ability, photosynthetic pigments
* **Plankton**: Trophic level, seasonal patterns

### 5. Data Views for Common Analyses
Custom views simplify complex queries:
* **Pathogenic_Microorganisms** - Lists all disease-causing organisms
* **Industrial_Microorganisms** - Shows organisms with commercial applications
* **Habitat_Distribution** - Analyzes biodiversity across environmental niches

## Sample Queries

### Find bacteria that produce commercially important enzymes
```sql
SELECT b.scientific_name, b.common_name, e.enzyme_name, e.industrial_use
FROM Bacteria b
JOIN Bacteria_Industrial_Applications bia ON b.bacteria_id = bia.bacteria_id
JOIN Industrial_Applications ia ON bia.application_id = ia.application_id
JOIN Microorganism_Enzymes me ON me.microorganism_id = b.bacteria_id 
  AND me.microorganism_type = 'Bacteria'
JOIN Enzymes_Produced e ON me.enzyme_id = e.enzyme_id
WHERE bia.commercial_importance IN ('High', 'Medium')
ORDER BY b.scientific_name;
SELECT 
    CASE 
        WHEN bh.bacteria_id IS NOT NULL THEN 'Bacteria'
        WHEN fh.fungi_id IS NOT NULL THEN 'Fungi'
        WHEN ph.protozoa_id IS NOT NULL THEN 'Protozoa'
    END AS organism_type,
    COALESCE(b.scientific_name, f.scientific_name, p.scientific_name) AS scientific_name,
    COALESCE(b.common_name, f.common_name, p.common_name) AS common_name,
    h.habitat_name,
    COALESCE(bh.prevalence, fh.prevalence, ph.prevalence) AS prevalence,
    COALESCE(b.pathogenicity, f.pathogenicity, p.pathogenicity) AS pathogenicity
FROM Habitats h
LEFT JOIN Bacteria_Habitats bh ON h.habitat_id = bh.habitat_id
LEFT JOIN Bacteria b ON bh.bacteria_id = b.bacteria_id
LEFT JOIN Fungi_Habitats fh ON h.habitat_id = fh.habitat_id
LEFT JOIN Fungi f ON fh.fungi_id = f.fungi_id
LEFT JOIN Protozoa_Habitats ph ON h.habitat_id = ph.habitat_id
LEFT JOIN Protozoa p ON ph.protozoa_id = p.protozoa_id
WHERE h.habitat_name = 'Human intestines' 
ORDER BY organism_type, scientific_name;
SELECT 
    COALESCE(cb.scientific_name, pl.scientific_name) AS scientific_name,
    h.habitat_name,
    COALESCE(cb.toxin_types, pl.toxin_types) AS toxin_types,
    COALESCE(cb.bloom_formation, pl.bloom_formation) AS forms_blooms
FROM Habitats h
LEFT JOIN Cyanobacteria_Habitats cbh ON h.habitat_id = cbh.habitat_id
LEFT JOIN Cyanobacteria cb ON cbh.cyanobacteria_id = cb.cyanobacteria_id 
  AND cb.toxin_production = TRUE
LEFT JOIN Plankton_Habitats plh ON h.habitat_id = plh.habitat_id
LEFT JOIN Plankton pl ON plh.plankton_id = pl.plankton_id 
  AND pl.toxin_production = TRUE
WHERE (cb.toxin_production = TRUE OR pl.toxin_production = TRUE)
AND h.habitat_name LIKE '%water%'
ORDER BY h.habitat_name;

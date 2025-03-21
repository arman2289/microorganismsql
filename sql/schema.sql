-- Enhanced Microorganisms Database
-- Created by: [Your Name]
-- Date: March 2025

-- Drop database if it exists and create a new one
DROP DATABASE IF EXISTS Microorganisms;
CREATE DATABASE Microorganisms;
USE Microorganisms;

-- Taxonomy table to standardize classifications
CREATE TABLE Taxonomy (
    taxonomy_id INT AUTO_INCREMENT PRIMARY KEY,
    domain VARCHAR(50) NOT NULL,
    kingdom VARCHAR(50) NOT NULL,
    phylum VARCHAR(50) NOT NULL,
    class VARCHAR(50) NOT NULL,
    taxonomic_order VARCHAR(50) NOT NULL, -- Using 'taxonomic_order' since 'order' is a reserved SQL keyword
    family VARCHAR(50) NOT NULL,
    genus VARCHAR(50) NOT NULL,
    discovery_year INT,
    discovered_by VARCHAR(100),
    UNIQUE KEY idx_taxonomy_unique (domain, kingdom, phylum, class, taxonomic_order, family, genus)
);

-- Habitats reference table
CREATE TABLE Habitats (
    habitat_id INT AUTO_INCREMENT PRIMARY KEY,
    habitat_name VARCHAR(100) NOT NULL,
    description TEXT,
    temperature_range VARCHAR(50),
    pH_range VARCHAR(50),
    oxygen_requirement ENUM('Aerobic', 'Anaerobic', 'Facultative anaerobe', 'Microaerophilic'),
    UNIQUE KEY idx_habitat_name (habitat_name)
);

-- Researchers table for tracking discoveries and studies
CREATE TABLE Researchers (
    researcher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    institution VARCHAR(150),
    country VARCHAR(50),
    field_of_study VARCHAR(100),
    active_years VARCHAR(50),
    contributions TEXT
);

-- Medical applications table
CREATE TABLE Medical_Applications (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    application_name VARCHAR(150) NOT NULL,
    description TEXT,
    development_stage ENUM('Research', 'Preclinical', 'Clinical trials', 'Approved', 'Established'),
    year_discovered INT,
    UNIQUE KEY idx_application_name (application_name)
);

-- Industrial applications table
CREATE TABLE Industrial_Applications (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    application_name VARCHAR(150) NOT NULL,
    industry VARCHAR(100),
    description TEXT,
    economic_importance ENUM('Low', 'Medium', 'High', 'Very High'),
    year_implemented INT,
    UNIQUE KEY idx_application_name (application_name)
);

-- Enhanced Bacteria Table
CREATE TABLE Bacteria (
    bacteria_id INT AUTO_INCREMENT PRIMARY KEY,
    taxonomy_id INT,
    scientific_name VARCHAR(100) NOT NULL,
    common_name VARCHAR(100),
    gram_stain ENUM('Positive', 'Negative', 'Variable', 'Not applicable'),
    morphology ENUM('Cocci', 'Bacilli', 'Spirilla', 'Vibrio', 'Pleomorphic'),
    arrangement VARCHAR(50),
    motility BOOLEAN,
    spore_formation BOOLEAN,
    optimal_temperature DECIMAL(5,2),
    optimal_pH DECIMAL(4,2),
    genome_size_mbp DECIMAL(6,3),
    pathogenicity ENUM('Non-pathogenic', 'Opportunistic pathogen', 'Primary pathogen'),
    antibiotic_resistance TEXT,
    description TEXT,
    notes TEXT,
    FOREIGN KEY (taxonomy_id) REFERENCES Taxonomy(taxonomy_id),
    UNIQUE KEY idx_bacteria_scientific_name (scientific_name)
);

-- Bacteria-Habitat relationship (many-to-many)
CREATE TABLE Bacteria_Habitats (
    bacteria_id INT NOT NULL,
    habitat_id INT NOT NULL,
    prevalence ENUM('Rare', 'Common', 'Abundant'),
    notes TEXT,
    PRIMARY KEY (bacteria_id, habitat_id),
    FOREIGN KEY (bacteria_id) REFERENCES Bacteria(bacteria_id),
    FOREIGN KEY (habitat_id) REFERENCES Habitats(habitat_id)
);

-- Bacteria-Medical Applications relationship (many-to-many)
CREATE TABLE Bacteria_Medical_Applications (
    bacteria_id INT NOT NULL,
    application_id INT NOT NULL,
    role_description TEXT,
    effectiveness ENUM('Low', 'Moderate', 'High', 'Very High'),
    PRIMARY KEY (bacteria_id, application_id),
    FOREIGN KEY (bacteria_id) REFERENCES Bacteria(bacteria_id),
    FOREIGN KEY (application_id) REFERENCES Medical_Applications(application_id)
);

-- Bacteria-Industrial Applications relationship (many-to-many)
CREATE TABLE Bacteria_Industrial_Applications (
    bacteria_id INT NOT NULL,
    application_id INT NOT NULL,
    role_description TEXT,
    commercial_importance ENUM('Low', 'Medium', 'High'),
    PRIMARY KEY (bacteria_id, application_id),
    FOREIGN KEY (bacteria_id) REFERENCES Bacteria(bacteria_id),
    FOREIGN KEY (application_id) REFERENCES Industrial_Applications(application_id)
);

-- Enhanced Fungi Table
CREATE TABLE Fungi (
    fungi_id INT AUTO_INCREMENT PRIMARY KEY,
    taxonomy_id INT,
    scientific_name VARCHAR(100) NOT NULL,
    common_name VARCHAR(100),
    type ENUM('Yeast', 'Mold', 'Mushroom', 'Mycorrhizal'),
    reproductive_structure VARCHAR(50),
    mycelium_characteristics TEXT,
    spore_type VARCHAR(50),
    optimal_temperature DECIMAL(5,2),
    optimal_pH DECIMAL(4,2),
    genome_size_mbp DECIMAL(6,3),
    pathogenicity ENUM('Non-pathogenic', 'Plant pathogen', 'Animal pathogen', 'Human pathogen'),
    antifungal_resistance TEXT,
    description TEXT,
    notes TEXT,
    FOREIGN KEY (taxonomy_id) REFERENCES Taxonomy(taxonomy_id),
    UNIQUE KEY idx_fungi_scientific_name (scientific_name)
);

-- Fungi-Habitat relationship (many-to-many)
CREATE TABLE Fungi_Habitats (
    fungi_id INT NOT NULL,
    habitat_id INT NOT NULL,
    prevalence ENUM('Rare', 'Common', 'Abundant'),
    notes TEXT,
    PRIMARY KEY (fungi_id, habitat_id),
    FOREIGN KEY (fungi_id) REFERENCES Fungi(fungi_id),
    FOREIGN KEY (habitat_id) REFERENCES Habitats(habitat_id)
);

-- Fungi-Medical Applications relationship (many-to-many)
CREATE TABLE Fungi_Medical_Applications (
    fungi_id INT NOT NULL,
    application_id INT NOT NULL,
    role_description TEXT,
    effectiveness ENUM('Low', 'Moderate', 'High', 'Very High'),
    PRIMARY KEY (fungi_id, application_id),
    FOREIGN KEY (fungi_id) REFERENCES Fungi(fungi_id),
    FOREIGN KEY (application_id) REFERENCES Medical_Applications(application_id)
);

-- Fungi-Industrial Applications relationship (many-to-many)
CREATE TABLE Fungi_Industrial_Applications (
    fungi_id INT NOT NULL,
    application_id INT NOT NULL,
    role_description TEXT,
    commercial_importance ENUM('Low', 'Medium', 'High'),
    PRIMARY KEY (fungi_id, application_id),
    FOREIGN KEY (fungi_id) REFERENCES Fungi(fungi_id),
    FOREIGN KEY (application_id) REFERENCES Industrial_Applications(application_id)
);

-- Enhanced Protozoa Table
CREATE TABLE Protozoa (
    protozoa_id INT AUTO_INCREMENT PRIMARY KEY,
    taxonomy_id INT,
    scientific_name VARCHAR(100) NOT NULL,
    common_name VARCHAR(100),
    type ENUM('Amoeboid', 'Flagellate', 'Ciliate', 'Sporozoan'),
    locomotion VARCHAR(50),
    cell_structure TEXT,
    reproduction_method VARCHAR(100),
    lifecycle_stages TEXT,
    genome_size_mbp DECIMAL(6,3),
    pathogenicity ENUM('Non-pathogenic', 'Pathogenic'),
    treatment_options TEXT,
    description TEXT,
    notes TEXT,
    FOREIGN KEY (taxonomy_id) REFERENCES Taxonomy(taxonomy_id),
    UNIQUE KEY idx_protozoa_scientific_name (scientific_name)
);

-- Protozoa-Habitat relationship (many-to-many)
CREATE TABLE Protozoa_Habitats (
    protozoa_id INT NOT NULL,
    habitat_id INT NOT NULL,
    prevalence ENUM('Rare', 'Common', 'Abundant'),
    notes TEXT,
    PRIMARY KEY (protozoa_id, habitat_id),
    FOREIGN KEY (protozoa_id) REFERENCES Protozoa(protozoa_id),
    FOREIGN KEY (habitat_id) REFERENCES Habitats(habitat_id)
);

-- Protozoa-Medical Applications relationship (many-to-many)
CREATE TABLE Protozoa_Medical_Applications (
    protozoa_id INT NOT NULL,
    application_id INT NOT NULL,
    role_description TEXT,
    PRIMARY KEY (protozoa_id, application_id),
    FOREIGN KEY (protozoa_id) REFERENCES Protozoa(protozoa_id),
    FOREIGN KEY (application_id) REFERENCES Medical_Applications(application_id)
);

-- Enhanced Cyanobacteria Table
CREATE TABLE Cyanobacteria (
    cyanobacteria_id INT AUTO_INCREMENT PRIMARY KEY,
    taxonomy_id INT,
    scientific_name VARCHAR(100) NOT NULL,
    common_name VARCHAR(100),
    morphology ENUM('Unicellular', 'Filamentous', 'Colonial'),
    nitrogen_fixation BOOLEAN,
    toxin_production BOOLEAN,
    toxin_types TEXT,
    photosynthetic_pigments TEXT,
    genome_size_mbp DECIMAL(6,3),
    ecological_importance TEXT,
    bloom_formation BOOLEAN,
    description TEXT,
    notes TEXT,
    FOREIGN KEY (taxonomy_id) REFERENCES Taxonomy(taxonomy_id),
    UNIQUE KEY idx_cyanobacteria_scientific_name (scientific_name)
);

-- Cyanobacteria-Habitat relationship (many-to-many)
CREATE TABLE Cyanobacteria_Habitats (
    cyanobacteria_id INT NOT NULL,
    habitat_id INT NOT NULL,
    prevalence ENUM('Rare', 'Common', 'Abundant'),
    notes TEXT,
    PRIMARY KEY (cyanobacteria_id, habitat_id),
    FOREIGN KEY (cyanobacteria_id) REFERENCES Cyanobacteria(cyanobacteria_id),
    FOREIGN KEY (habitat_id) REFERENCES Habitats(habitat_id)
);

-- Cyanobacteria-Industrial Applications relationship (many-to-many)
CREATE TABLE Cyanobacteria_Industrial_Applications (
    cyanobacteria_id INT NOT NULL,
    application_id INT NOT NULL,
    role_description TEXT,
    commercial_importance ENUM('Low', 'Medium', 'High'),
    PRIMARY KEY (cyanobacteria_id, application_id),
    FOREIGN KEY (cyanobacteria_id) REFERENCES Cyanobacteria(cyanobacteria_id),
    FOREIGN KEY (application_id) REFERENCES Industrial_Applications(application_id)
);

-- Enhanced Plankton Table 
CREATE TABLE Plankton (
    plankton_id INT AUTO_INCREMENT PRIMARY KEY,
    taxonomy_id INT,
    scientific_name VARCHAR(100) NOT NULL,
    common_name VARCHAR(100),
    type ENUM('Phytoplankton', 'Zooplankton', 'Bacterioplankton', 'Mixoplankton'),
    size_range VARCHAR(50),
    trophic_level VARCHAR(50),
    season_of_abundance VARCHAR(50),
    bloom_formation BOOLEAN,
    ecological_importance TEXT,
    toxin_production BOOLEAN,
    toxin_types TEXT,
    description TEXT,
    notes TEXT,
    FOREIGN KEY (taxonomy_id) REFERENCES Taxonomy(taxonomy_id),
    UNIQUE KEY idx_plankton_scientific_name (scientific_name)
);

-- Plankton-Habitat relationship (many-to-many)
CREATE TABLE Plankton_Habitats (
    plankton_id INT NOT NULL,
    habitat_id INT NOT NULL,
    prevalence ENUM('Rare', 'Common', 'Abundant'),
    seasonal_patterns TEXT,
    PRIMARY KEY (plankton_id, habitat_id),
    FOREIGN KEY (plankton_id) REFERENCES Plankton(plankton_id),
    FOREIGN KEY (habitat_id) REFERENCES Habitats(habitat_id)
);

-- Research Studies table
CREATE TABLE Research_Studies (
    study_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    researcher_id INT,
    publication_date DATE,
    journal VARCHAR(150),
    study_focus TEXT,
    key_findings TEXT,
    methodology TEXT,
    FOREIGN KEY (researcher_id) REFERENCES Researchers(researcher_id)
);

-- Microorganism-Study relationship (many-to-many)
CREATE TABLE Microorganism_Studies (
    study_id INT NOT NULL,
    microorganism_type ENUM('Bacteria', 'Fungi', 'Protozoa', 'Cyanobacteria', 'Plankton') NOT NULL,
    microorganism_id INT NOT NULL,
    study_outcome TEXT,
    PRIMARY KEY (study_id, microorganism_type, microorganism_id),
    FOREIGN KEY (study_id) REFERENCES Research_Studies(study_id)
);

-- Genetic_Sequences table
CREATE TABLE Genetic_Sequences (
    sequence_id INT AUTO_INCREMENT PRIMARY KEY,
    microorganism_type ENUM('Bacteria', 'Fungi', 'Protozoa', 'Cyanobacteria', 'Plankton') NOT NULL,
    microorganism_id INT NOT NULL,
    sequence_type ENUM('Genome', '16S rRNA', 'ITS', '18S rRNA', 'Mitochondrial'),
    accession_number VARCHAR(50),
    sequence_length INT,
    gc_content DECIMAL(5,2),
    sequencing_method VARCHAR(100),
    sequencing_date DATE,
    notes TEXT
);

-- Disease table
CREATE TABLE Diseases (
    disease_id INT AUTO_INCREMENT PRIMARY KEY,
    disease_name VARCHAR(100) NOT NULL,
    causative_agent_type ENUM('Bacteria', 'Fungi', 'Protozoa', 'Cyanobacteria', 'Virus', 'Prion', 'Other'),
    causative_agent_id INT,
    transmission_method TEXT,
    symptoms TEXT,
    diagnosis_method TEXT,
    treatment TEXT,
    prevention TEXT,
    geographical_distribution TEXT,
    mortality_rate VARCHAR(50),
    notes TEXT,
    UNIQUE KEY idx_disease_name (disease_name)
);

-- Microorganisms-Disease relationship (many-to-many)
CREATE TABLE Microorganism_Diseases (
    disease_id INT NOT NULL,
    microorganism_type ENUM('Bacteria', 'Fungi', 'Protozoa', 'Cyanobacteria', 'Plankton') NOT NULL,
    microorganism_id INT NOT NULL,
    role_in_disease ENUM('Primary causative agent', 'Secondary agent', 'Opportunistic', 'Carrier'),
    notes TEXT,
    PRIMARY KEY (disease_id, microorganism_type, microorganism_id),
    FOREIGN KEY (disease_id) REFERENCES Diseases(disease_id)
);

-- Enzymes_Produced table
CREATE TABLE Enzymes_Produced (
    enzyme_id INT AUTO_INCREMENT PRIMARY KEY,
    enzyme_name VARCHAR(100) NOT NULL,
    enzyme_function TEXT,
    industrial_use TEXT,
    medical_use TEXT,
    optimum_temperature DECIMAL(5,2),
    optimum_pH DECIMAL(4,2),
    UNIQUE KEY idx_enzyme_name (enzyme_name)
);

-- Microorganisms-Enzymes relationship (many-to-many)
CREATE TABLE Microorganism_Enzymes (
    enzyme_id INT NOT NULL,
    microorganism_type ENUM('Bacteria', 'Fungi', 'Protozoa', 'Cyanobacteria', 'Plankton') NOT NULL,
    microorganism_id INT NOT NULL,
    production_efficiency ENUM('Low', 'Medium', 'High'),
    commercial_extraction BOOLEAN,
    notes TEXT,
    PRIMARY KEY (enzyme_id, microorganism_type, microorganism_id),
    FOREIGN KEY (enzyme_id) REFERENCES Enzymes_Produced(enzyme_id)
);

-- Antimicrobial_Compounds table
CREATE TABLE Antimicrobial_Compounds (
    compound_id INT AUTO_INCREMENT PRIMARY KEY,
    compound_name VARCHAR(100) NOT NULL,
    chemical_class VARCHAR(100),
    mechanism_of_action TEXT,
    spectrum_of_activity TEXT,
    discovery_year INT,
    discovered_by INT,
    clinical_use TEXT,
    resistance_mechanisms TEXT,
    FOREIGN KEY (discovered_by) REFERENCES Researchers(researcher_id),
    UNIQUE KEY idx_compound_name (compound_name)
);

-- Microorganisms-Antimicrobial_Compounds relationship (many-to-many)
CREATE TABLE Microorganism_Antimicrobials (
    compound_id INT NOT NULL,
    microorganism_type ENUM('Bacteria', 'Fungi', 'Protozoa', 'Cyanobacteria', 'Plankton') NOT NULL,
    microorganism_id INT NOT NULL,
    relationship_type ENUM('Producer', 'Target', 'Resistant to'),
    notes TEXT,
    PRIMARY KEY (compound_id, microorganism_type, microorganism_id),
    FOREIGN KEY (compound_id) REFERENCES Antimicrobial_Compounds(compound_id)
);

-- Sample data insertion for Taxonomy
INSERT INTO Taxonomy (domain, kingdom, phylum, class, taxonomic_order, family, genus, discovery_year, discovered_by) VALUES
-- Bacteria
('Bacteria', 'Bacteria', 'Proteobacteria', 'Gammaproteobacteria', 'Enterobacterales', 'Enterobacteriaceae', 'Escherichia', 1885, 'Theodor Escherich'),
('Bacteria', 'Bacteria', 'Firmicutes', 'Bacilli', 'Bacillales', 'Bacillaceae', 'Bacillus', 1872, 'Ferdinand Cohn'),
('Bacteria', 'Bacteria', 'Firmicutes', 'Bacilli', 'Bacillales', 'Staphylococcaceae', 'Staphylococcus', 1880, 'Alexander Ogston'),
('Bacteria', 'Bacteria', 'Proteobacteria', 'Gammaproteobacteria', 'Pseudomonadales', 'Pseudomonadaceae', 'Pseudomonas', 1894, 'Walter Migula'),
('Bacteria', 'Bacteria', 'Firmicutes', 'Bacilli', 'Lactobacillales', 'Lactobacillaceae', 'Lactobacillus', 1901, 'Martinus Beijerinck'),
('Bacteria', 'Bacteria', 'Firmicutes', 'Clostridia', 'Clostridiales', 'Clostridiaceae', 'Clostridium', 1880, 'John Hall-Edwards'),
('Bacteria', 'Bacteria', 'Proteobacteria', 'Gammaproteobacteria', 'Enterobacterales', 'Enterobacteriaceae', 'Salmonella', 1885, 'Theobald Smith'),
('Bacteria', 'Bacteria', 'Actinobacteria', 'Actinomycetia', 'Mycobacteriales', 'Mycobacteriaceae', 'Mycobacterium', 1882, 'Robert Koch'),
('Bacteria', 'Bacteria', 'Proteobacteria', 'Gammaproteobacteria', 'Vibrionales', 'Vibrionaceae', 'Vibrio', 1854, 'Filippo Pacini'),
('Bacteria', 'Bacteria', 'Proteobacteria', 'Epsilonproteobacteria', 'Campylobacterales', 'Helicobacteraceae', 'Helicobacter', 1982, 'Barry Marshall and Robin Warren'),
('Bacteria', 'Bacteria', 'Firmicutes', 'Bacilli', 'Lactobacillales', 'Streptococcaceae', 'Streptococcus', 1874, 'Theodor Billroth'),
('Bacteria', 'Bacteria', 'Proteobacteria', 'Betaproteobacteria', 'Burkholderiales', 'Burkholderiaceae', 'Burkholderia', 1992, 'Yabuuchi et al.'),
('Bacteria', 'Bacteria', 'Firmicutes', 'Negativicutes', 'Veillonellales', 'Veillonellaceae', 'Veillonella', 1898, 'Veillon and Zuber'),

-- Fungi
('Eukarya', 'Fungi', 'Ascomycota', 'Saccharomycetes', 'Saccharomycetales', 'Saccharomycetaceae', 'Saccharomyces', 1837, 'Franz Meyen'),
('Eukarya', 'Fungi', 'Ascomycota', 'Eurotiomycetes', 'Eurotiales', 'Aspergillaceae', 'Penicillium', 1809, 'Johann Heinrich Friedrich Link'),
('Eukarya', 'Fungi', 'Ascomycota', 'Eurotiomycetes', 'Eurotiales', 'Aspergillaceae', 'Aspergillus', 1729, 'Pier Antonio Micheli'),
('Eukarya', 'Fungi', 'Ascomycota', 'Saccharomycetes', 'Saccharomycetales', 'Debaryomycetaceae', 'Candida', 1923, 'Christine Marie Berkhout'),
('Eukarya', 'Fungi', 'Mucoromycota', 'Mucoromycetes', 'Mucorales', 'Rhizopodaceae', 'Rhizopus', 1821, 'Christian Gottfried Ehrenberg'),
('Eukarya', 'Fungi', 'Ascomycota', 'Sordariomycetes', 'Hypocreales', 'Hypocreaceae', 'Trichoderma', 1794, 'Christiaan Hendrik Persoon'),
('Eukarya', 'Fungi', 'Basidiomycota', 'Tremellomycetes', 'Tremellales', 'Cryptococcaceae', 'Cryptococcus', 1894, 'Francesco Sanfelice'),
('Eukarya', 'Fungi', 'Mucoromycota', 'Mucoromycetes', 'Mucorales', 'Mucoraceae', 'Mucor', 1794, 'Christiaan Hendrik Persoon'),
('Eukarya', 'Fungi', 'Ascomycota', 'Sordariomycetes', 'Hypocreales', 'Nectriaceae', 'Fusarium', 1809, 'Johann Heinrich Friedrich Link'),
('Eukarya', 'Fungi', 'Ascomycota', 'Dothideomycetes', 'Pleosporales', 'Pleosporaceae', 'Alternaria', 1817, 'Christian Gottfried Nees von Esenbeck'),
('Eukarya', 'Fungi', 'Basidiomycota', 'Agaricomycetes', 'Agaricales', 'Amanitaceae', 'Amanita', 1797, 'Christiaan Hendrik Persoon'),
('Eukarya', 'Fungi', 'Basidiomycota', 'Agaricomycetes', 'Polyporales', 'Ganodermataceae', 'Ganoderma', 1881, 'Petter Adolf Karsten'),

-- Protozoa
('Eukarya', 'Protozoa', 'Amoebozoa', 'Tubulinea', 'Tubulinida', 'Amoebidae', 'Amoeba', 1755, 'August Johann Rösel von Rosenhof'),
('Eukarya', 'Protozoa', 'Ciliophora', 'Oligohymenophorea', 'Peniculida', 'Parameciidae', 'Paramecium', 1752, 'John Hill'),
('Eukarya', 'Protozoa', 'Euglenozoa', 'Euglenoidea', 'Euglenales', 'Euglenaceae', 'Euglena', 1830, 'Christian Gottfried Ehrenberg'),
('Eukarya', 'Protozoa', 'Apicomplexa', 'Aconoidasida', 'Haemosporida', 'Plasmodiidae', 'Plasmodium', 1885, 'Ettore Marchiafava and Angelo Celli'),
('Eukarya', 'Protozoa', 'Euglenozoa', 'Kinetoplastea', 'Trypanosomatida', 'Trypanosomatidae', 'Trypanosoma', 1841, 'Gabriel Valentin'),
('Eukarya', 'Protozoa', 'Apicomplexa', 'Conoidasida', 'Eucoccidiorida', 'Cryptosporidiidae', 'Cryptosporidium', 1907, 'Ernest Edward Tyzzer'),
('Eukarya', 'Protozoa', 'Apicomplexa', 'Conoidasida', 'Eucoccidiorida', 'Eimeriidae', 'Toxoplasma', 1908, 'Charles Nicolle and Louis Manceaux'),
('Eukarya', 'Protozoa', 'Amoebozoa', 'Archamoebae', 'Entamoebida', 'Entamoebidae', 'Entamoeba', 1875, 'Fedor Aleksandrovich Lösch'),

-- Cyanobacteria
('Bacteria', 'Cyanobacteria', 'Cyanobacteria', 'Cyanophyceae', 'Nostocales', 'Nostocaceae', 'Anabaena', 1839, 'Jean-Baptiste Bory de Saint-Vincent'),
('Bacteria', 'Cyanobacteria', 'Cyanobacteria', 'Cyanophyceae', 'Nostocales', 'Nostocaceae', 'Nostoc', 1753, 'Carl Linnaeus'),
('Bacteria', 'Cyanobacteria', 'Cyanobacteria', 'Cyanophyceae', 'Chroococcales', 'Microcystaceae', 'Microcystis', 1833, 'Friedrich Traugott Kützing'),
('Bacteria', 'Cyanobacteria', 'Cyanobacteria', 'Cyanophyceae', 'Oscillatoriales', 'Oscillatoriaceae', 'Oscillatoria', 1803, 'Jean Pierre Étienne Vaucher'),
('Bacteria', 'Cyanobacteria', 'Cyanobacteria', 'Cyanophyceae', 'Synechococcales', 'Synechococcaceae', 'Synechococcus', 1924, 'Carlo Nägeli'),

-- Plankton
('Eukarya', 'Chromista', 'Bacillariophyta', 'Bacillariophyceae', 'Thalassiosirales', 'Thalassiosiraceae', 'Thalassiosira', 1873, 'P.T. Cleve'),
('Eukarya', 'Chromista', 'Miozoa', 'Dinophyceae', 'Gonyaulacales', 'Goniodomataceae', 'Alexandrium', 1960, 'Alfred R. Loeblich'),
('Eukarya', 'Chromista', 'Haptophyta', 'Prymnesiophyceae', 'Isochrysidales', 'Noelaerhabdaceae', 'Emiliania', 1954, 'Markali and Paasche'),
('Eukarya', 'Animalia', 'Arthropoda', 'Crustacea', 'Calanoida', 'Calanidae', 'Calanus', 1816, 'William Elford Leach'),
('Eukarya', 'Chromista', 'Bacillariophyta', 'Coscinodiscophyceae', 'Coscinodiscales', 'Coscinodiscaceae', 'Coscinodiscus', 1838, 'Christian Gottfried Ehrenberg');

-- Sample data insertion for Habitats
INSERT INTO Habitats (habitat_name, description, temperature_range, pH_range, oxygen_requirement) VALUES
('Human intestines', 'The digestive tract of humans', '36-38°C', '5.5-7.0', 'Facultative anaerobe'),
('Soil', 'Upper layer of earth in which plants grow', '10-25°C', '6.0-7.5', 'Aerobic'),
('Freshwater', 'Non-saline water bodies like lakes and rivers', '4-25°C', '6.5-8.0', 'Aerobic'),
('Marine environments', 'Saltwater ecosystems including oceans and seas', '2-30°C', '7.5-8.4', 'Aerobic'),
('Human skin', 'Outer covering of the human body', '30-35°C', '4.0-6.0', 'Aerobic'),
('Extreme environments', 'Habitats with extreme conditions (temperature, pH, etc.)', 'Variable', 'Variable', 'Variable'),
('Human respiratory tract', 'Airways involved in breathing', '36-37°C', '6.8-7.4', 'Aerobic'),
('Dental plaque', 'Biofilm on tooth surfaces', '36-37°C', '5.5-7.0', 'Anaerobic'),
('Hospital environments', 'Clinical settings including surfaces and equipment', '18-25°C', '6.0-8.0', 'Aerobic'),
('Human urogenital tract', 'Urinary and reproductive systems', '36-37°C', '3.8-4.5', 'Facultative anaerobe'),
('Fermented foods', 'Food products produced through controlled microbial growth', '20-40°C', '4.0-6.0', 'Facultative anaerobe'),
('Wastewater', 'Used water from domestic, industrial, commercial sources', '10-30°C', '6.0-8.0', 'Variable'),
('Hot springs', 'Geothermally heated springs', '45-80°C', '2.0-9.0', 'Variable'),
('Deep sea vents', 'Hydrothermal vents on the ocean floor', '2-400°C', '2.0-8.0', 'Variable'),
('Permafrost', 'Permanently frozen soil', '-20-0°C', '6.0-8.0', 'Microaerophilic'),
('Human blood', 'Circulatory fluid in humans', '37°C', '7.35-7.45', 'Aerobic'),
('Plant surfaces', 'Exterior parts of plants like leaves and stems', '15-30°C', '5.5-7.5', 'Aerobic'),
('Plant roots', 'Root systems of plants', '10-25°C', '5.5-7.0', 'Variable'),
('Decaying organic matter', 'Decomposing plant and animal material', '15-30°C', '4.5-8.0', 'Variable');

-- Sample data insertion for Researchers
INSERT INTO Researchers (name, institution, country, field_of_study, active_years, contributions) VALUES
('Alexander Fleming', 'St. Mary''s Hospital', 'United Kingdom', 'Bacteriology', '1928-1955', 'Discovered penicillin'),
('Robert Koch', 'Imperial Health Office', 'Germany', 'Microbiology', '1876-1910', 'Discovered tuberculosis bacterium'),
('Louis Pasteur', 'Ecole Normale Superieure', 'France', 'Microbiology', '1857-1895', 'Developed pasteurization and vaccines'),
('Barry Marshall', 'University of Western Australia', 'Australia', 'Gastroenterology', '1982-present', 'Discovered H. pylori as cause of ulcers'),
('Carl Woese', 'University of Illinois', 'USA', 'Microbiology', '1960-2012', 'Discovered Archaea domain'),
('Lynn Margulis', 'University of Massachusetts', 'USA', 'Evolutionary Biology', '1960-2011', 'Endosymbiotic theory'),
('Selman Waksman', 'Rutgers University', 'USA', 'Soil Microbiology', '1915-1973', 'Discovered streptomycin'),
('Teruo Higa', 'University of the Ryukyus', 'Japan', 'Agricultural Microbiology', '1970-present', 'Developed effective microorganisms technology'),
('Ruth E. Moore', 'Howard University', 'USA', 'Bacteriology', '1940-1990', 'Advanced understanding of tuberculosis'),
('Emmanuelle Charpentier', 'Max Planck Unit', 'Germany', 'Microbiology', '1995-present', 'Co-discovery of CRISPR-Cas9');

-- Sample Medical Applications
INSERT INTO Medical_Applications (application_name, description, development_stage, year_discovered) VALUES
('Antibiotic production', 'Production of antibiotics for treating bacterial infections', 'Established', 1928),
('Vaccine production', 'Use of microorganisms in vaccine development and production', 'Established', 1885),
('Enzyme therapy', 'Using microbial enzymes to treat diseases', 'Approved', 1985),
('Probiotics', 'Beneficial microorganisms used to promote gut health', 'Established', 1908),
('Antimicrobial peptide research', 'Development of peptides with antimicrobial properties', 'Clinical trials', 1995),
('Recombinant insulin production', 'Using bacteria to produce human insulin', 'Established', 1978),
('Gene therapy vectors', 'Using viruses as delivery vehicles for genetic material', 'Clinical trials', 1990),
('Cancer immunotherapy', 'Using microorganisms to stimulate immune response against cancer', 'Clinical trials', 2005),
('Antibody production', 'Using microorganisms to produce therapeutic antibodies', 'Established', 1975),
('Diagnostic reagents', 'Microorganisms used in clinical diagnostic tests', 'Established', 1965);

-- Sample Industrial Applications
INSERT INTO Industrial_Applications (application_name, industry, description, economic_importance, year_implemented) VALUES
('Fermentation', 'Food & Beverage', 'Producing alcoholic beverages, bread, and fermented foods', 'Very High', 7000),
('Biofuel production', 'Energy', 'Using microorganisms to produce fuels like ethanol', 'High', 1975),
('Enzyme production', 'Biotechnology', 'Industrial-scale production of enzymes for various industries', 'High', 1950),
('Wastewater treatment', 'Environmental', 'Using microbes to break down waste in water', 'Very High', 1914),
('Bioremediation', 'Environmental', 'Using microorganisms to clean polluted environments', 'High', 1972),
('Bioleaching', 'Mining', 'Using microbes to extract metals from ores', 'Medium', 1958),
('Single cell protein', 'Food', 'Microbial biomass used as protein supplement', 'Medium', 1960),
('Bioplastic production', 'Materials', 'Using bacteria to produce biodegradable plastics', 'Medium', 1995),
('Citric acid production', 'Food & Chemical', 'Using fungi to produce citric acid', 'High', 1923),
('Biocontrol agents', 'Agriculture', 'Using microorganisms to control pests and diseases', 'Medium', 1970);

-- Sample data insertion for enhanced Bacteria table
INSERT INTO Bacteria (taxonomy_id, scientific_name, common_name, gram_stain, morphology, arrangement, motility, spore_formation, optimal_temperature, optimal_pH, genome_size_mbp, pathogenicity, antibiotic_resistance, description, notes) VALUES
(1, 'Escherichia coli', 'E. coli', 'Negative', 'Bacilli', 'Single or pairs', TRUE, FALSE, 37.0, 7.0, 4.6, 'Opportunistic pathogen', 'Some strains show resistance to multiple antibiotics including ampicillin and tetracycline', 'Common inhabitant of the lower intestine of warm-blooded organisms. Most strains are harmless, but some can cause food poisoning.', 'Widely used as a model organism in microbiology and biotechnology'),
(2, 'Bacillus subtilis', 'Hay bacillus', 'Positive', 'Bacilli', 'Chains', TRUE, TRUE, 37.0, 7.0, 4.2, 'Non-pathogenic', 'Naturally resistant to some antibiotics', 'Commonly found in soil and the gastrointestinal tract of humans. Used as a model organism for bacterial studies.', 'Important in production of industrial enzymes'),
(3, 'Staphylococcus aureus', 'Golden staph', 'Positive', 'Cocci', 'Clusters', FALSE, FALSE, 37.0, 7.0, 2.8, 'Primary pathogen', 'MRSA strains resistant to methicillin and other beta-lactams', 'Common cause of skin infections, respiratory disease, and food poisoning.', 'Major cause of hospital-acquired infections'),
(4, 'Pseudomonas aeruginosa', NULL, 'Negative', 'Bacilli', 'Single or pairs', TRUE, FALSE, 37.0, 7.0, 6.3, 'Opportunistic pathogen', 'Intrinsically resistant to many antibiotics due to efflux pumps and beta-lactamases', 'Versatile pathogen that can cause infections in plants and animals. Common cause of hospital-acquired infections.', 'Produces blue-green pigment pyocyanin'),
(5, 'Lactobacillus acidophilus', NULL, 'Positive', 'Bacilli', 'Chains', FALSE, FALSE, 37.0, 5.5, 2.0, 'Non-pathogenic', 'Naturally resistant to vancomycin', 'Used in production of yogurt and other fermented foods. Considered beneficial for human gut health.', 'Common probiotic organism'),
(6, 'Clostridium botulinum', NULL, 'Positive', 'Bacilli', 'Single or pairs', TRUE, TRUE, 37.0, 7.0, 3.9, 'Primary pathogen', 'Susceptible to most antibiotics', 'Produces the neurotoxin botulinum, which causes botulism. Grows in anaerobic conditions.', 'Botulinum toxin is one of the most potent natural toxins known'),
(7, 'Salmonella enterica', 'Salmonella', 'Negative', 'Bacilli', 'Single', TRUE, FALSE, 37.0, 7.0, 4.8, 'Primary pathogen', 'Increasing resistance to fluoroquinolones and third-generation cephalosporins', 'Causes salmonellosis, a common foodborne illness. Can infect a wide range of animals.', 'Over 2,500 different serotypes identified'),
(8, 'Mycobacterium tuberculosis', 'TB bacterium', 'Acid-fast', 'Bacilli', 'Cords', FALSE, FALSE, 37.0, 6.8, 4.4, 'Primary pathogen', 'Multi-drug resistant (MDR) and extensively drug-resistant (XDR) strains are emerging', 'Causative agent of tuberculosis, primarily affecting the lungs.', 'Has a unique cell wall with high lipid content making it difficult to treat'),
(9, 'Vibrio cholerae', 'Cholera bacterium', 'Negative', 'Vibrio', 'Single', TRUE, FALSE, 37.0, 8.0, 4.0, 'Primary pathogen', 'Resistance to tetracyclines, trimethoprim-sulfamethoxazole emerging', 'Causes cholera, a severe diarrheal disease. Transmitted through contaminated water.', 'Produces cholera toxin that causes massive fluid secretion'),
(10, 'Helicobacter pylori', NULL, 'Negative', 'Spirilla', 'Single', TRUE, FALSE, 37.0, 6.0, 1.6, 'Primary pathogen', 'Increasing resistance to clarithromycin, metronidazole, and levofloxacin', 'Colonizes the stomach and is the main cause of peptic ulcers and gastritis.', 'Produces urease to neutralize stomach acid'),
(11, 'Streptococcus pneumoniae', 'Pneumococcus', 'Positive', 'Cocci', 'Pairs or chains', FALSE, FALSE, 37.0, 7.0, 2.1, 'Primary pathogen', 'Increasing resistance to penicillin and macrolides', 'Leading cause of pneumonia, meningitis, and sinusitis.', 'Encapsulated bacterium with over 90 serotypes'),
(12, 'Burkholderia cepacia', NULL, 'Negative', 'Bacilli', 'Single or pairs', TRUE, FALSE, 30.0, 7.0, 8.0, 'Opportunistic pathogen', 'Intrinsically resistant to many antibiotics', 'Causes severe lung infections in cystic fibrosis patients.', 'Originally identified as a plant pathogen'),
(13, 'Veillonella parvula', NULL, 'Negative', 'Cocci', 'Pairs or clusters', FALSE, FALSE, 37.0, 7.0, 2.1, 'Opportunistic pathogen', 'Resistance to metronidazole reported', 'Anaerobic bacterium commonly found in the mouth and intestinal tract.', 'One of the few gram-negative cocci');

-- Sample data insertion for Bacteria-Habitat relationships
INSERT INTO Bacteria_Habitats (bacteria_id, habitat_id, prevalence, notes) VALUES
(1, 1, 'Abundant', 'Primary habitat, forms significant part of gut microbiome'),
(1, 2, 'Common', 'Found in soil contaminated with fecal matter'),
(1, 3, 'Common', 'Indicator of fecal contamination in water'),
(2, 2, 'Abundant', 'Common soil bacterium'),
(2, 17, 'Common', 'Found on plant surfaces'),
(3, 5, 'Common', 'Natural part of skin microbiome in 20-30% of population'),
(3, 9, 'Common', 'Problematic in hospital environments'),
(4, 2, 'Common', 'Widely distributed in soil'),
(4, 3, 'Common', 'Found in various water sources'),
(4, 9, 'Common', 'Problematic in hospital settings due to resistance'),
(5, 1, 'Common', 'Part of normal gut flora'),
(5, 11, 'Abundant', 'Used in fermentation of dairy products'),
(6, 2, 'Common', 'Soil is natural reservoir'),
(6, 19, 'Common', 'Grows in improperly preserved food'),
(7, 1, 'Rare', 'Present during infection'),
(7, 2, 'Common', 'Can persist in soil'),
(8, 7, 'Rare', 'Present during active infection'),
(9, 3, 'Rare', 'Found in contaminated freshwater'),
(9, 4, 'Common', 'Natural aquatic reservoirs, especially brackish water'),
(10, 1, 'Rare', 'Found in gastric mucosa of infected individuals');

-- Sample data insertion for enhanced Fungi table
INSERT INTO Fungi (taxonomy_id, scientific_name, common_name, type, reproductive_structure, mycelium_characteristics, spore_type, optimal_temperature, optimal_pH, genome_size_mbp, pathogenicity, antifungal_resistance, description, notes) VALUES
(14, 'Saccharomyces cerevisiae', 'Baker''s yeast', 'Yeast', 'Ascospores', 'Unicellular', 'Ascospores', 30.0, 5.5, 12.1, 'Non-pathogenic', NULL, 'Used in baking, brewing, and as a model organism in cell biology research.', 'First eukaryotic genome to be completely sequenced'),
(15, 'Penicillium notatum', 'Penicillium mold', 'Mold', 'Conidiophores', 'Septate hyphae', 'Conidia', 25.0, 5.5, 32.7, 'Non-pathogenic', NULL, 'Source of the first antibiotic penicillin discovered by Alexander Fleming.', 'Revolutionized medicine through antibiotic production'),
(16, 'Aspergillus niger', 'Black mold', 'Mold', 'Conidiophores', 'Septate hyphae', 'Conidia', 35.0, 6.0, 34.0, 'Opportunistic pathogen', 'Some resistance to amphotericin B', 'Used industrially to produce citric acid and enzymes. Can cause aspergillosis in immunocompromised individuals.', 'Produces dark black spores'),
(17, 'Candida albicans', 'Candida', 'Yeast', 'Pseudohyphae', 'Dimorphic (yeast and hyphal forms)', 'Blastoconidia', 37.0, 6.0, 14.5, 'Opportunistic pathogen', 'Increasing resistance to fluconazole', 'Normal component of gut flora but can cause infections when immune system is compromised.', 'Leading cause of fungal infections in humans'),
(18, 'Rhizopus stolonifer', 'Black bread mold', 'Mold', 'Sporangia', 'Coenocytic hyphae', 'Sporangiospores', 25.0, 6.0, 45.0, 'Opportunistic pathogen', 'Resistant to many antifungals', 'Common bread spoilage organism. Can cause mucormycosis in immunocompromised individuals.', 'Rapid growth rate'),
(19, 'Trichoderma harzianum', NULL, 'Mold', 'Conidiophores', 'Septate hyphae', 'Conidia', 28.0, 6.0, 40.0, 'Non-pathogenic', NULL, 'Used as a biocontrol agent against plant pathogenic fungi.', 'Produces enzymes that break down fungal cell walls'),
(20, 'Cryptococcus neoformans', NULL, 'Yeast', 'Basidiospores', 'Encapsulated yeast cells', 'Basidiospores', 30.0, 7.0, 19.0, 'Primary pathogen', 'Some resistance to fluconazole', 'Causes cryptococcosis, primarily affecting the central nervous system.', 'Has a polysaccharide capsule that protects against immune response'),
(21, 'Mucor mucedo', NULL, 'Mold', 'Sporangia', 'Coenocytic hyphae', 'Sporangiospores', 20.0, 6.0, 42.0, 'Opportunistic pathogen', 'Resistant to many azole antifungals', 'Common soil fungus that can cause mucormycosis in immunocompromised patients.', 'Fast-growing mold'),
(22, 'Fusarium oxysporum', NULL, 'Mold', 'Conidiophores', 'Septate hyphae', 'Macroconidia and microconidia', 28.0, 6.0, 60.0, 'Plant pathogen', NULL, 'Causes vascular wilt disease in many plants. Some strains can infect humans.', 'Contains many specialized forms that affect specific plants'),
(23, 'Alternaria alternata', NULL, 'Mold', 'Conidiophores', 'Septate hyphae', 'Multicellular conidia', 25.0, 6.0, 33.0, 'Plant pathogen', NULL, 'Common plant pathogen causing leaf spots and blights. Can cause allergic reactions in humans.', 'Produces dark-colored spores with both transverse and longitudinal septa'),
(24, 'Amanita phalloides', 'Death Cap', 'Mushroom', 'Basidiocarp', 'Filamentous mycelium', 'Basidiospores', 20.0, 6.0, 40.0, 'Primary pathogen', NULL, 'Highly toxic mushroom containing amatoxins that cause liver failure.', 'Responsible for most fatal mushroom poisonings worldwide'),
(25, 'Ganoderma lucidum', 'Reishi', 'Mushroom', 'Basidiocarp', 'Filamentous mycelium', 'Basidiospores', 28.0, 6.0, 43.0, 'Non-pathogenic', NULL, 'Medicinal mushroom used in traditional Asian medicine for its immunomodulating properties.', 'Contains bioactive compounds including triterpenoids and polysaccharides');

-- Enhanced Protozoa data
INSERT INTO Protozoa (taxonomy_id, scientific_name, common_name, type, locomotion, cell_structure, reproduction_method, lifecycle_stages, genome_size_mbp, pathogenicity, treatment_options, description, notes) VALUES
(26, 'Amoeba proteus', 'Giant amoeba', 'Amoeboid', 'Pseudopodia', 'Single nucleus, contractile vacuole', 'Binary fission', 'Trophozoite, cyst', 290.0, 'Non-pathogenic', NULL, 'Free-living freshwater amoeba often used in biology education.', 'Classic example of amoeboid movement'),
(27, 'Paramecium caudatum', 'Slipper animalcule', 'Ciliate', 'Cilia', 'Two nuclei (macro and micro), oral groove', 'Binary fission, conjugation', 'Trophozoite', 200.0, 'Non-pathogenic', NULL, 'Ciliated protozoan common in freshwater environments.', 'Complex cellular structure with specialized organelles'),
(28, 'Euglena gracilis', NULL, 'Flagellate', 'Flagellum', 'Chloroplasts, eyespot, paramylon granules', 'Binary fission', 'Motile cell', 100.0, 'Non-pathogenic', NULL, 'Photosynthetic flagellate with plant and animal characteristics.', 'Can switch between autotrophic and heterotrophic nutrition'),
(29, 'Plasmodium falciparum', 'Malaria parasite', 'Sporozoan', 'Gliding', 'Apical complex, specialized organelles', 'Sexual and asexual cycles', 'Sporozoite, merozoite, trophozoite, schizont, gametocyte', 23.3, 'Primary pathogen', 'Chloroquine, artemisinin-based combination therapies', 'Causes the most severe form of malaria. Transmitted by Anopheles mosquitoes.', 'Developing resistance to many antimalarial drugs'),
(30, 'Trypanosoma brucei', 'Sleeping sickness parasite', 'Flagellate', 'Flagellum', 'Kinetoplast, glycosomes', 'Binary fission', 'Trypomastigote in blood, epimastigote in tsetse fly', 26.0, 'Primary pathogen', 'Pentamidine, suramin, melarsoprol', 'Causes African sleeping sickness. Transmitted by tsetse flies.', 'Evades host immune system through antigenic variation'),
(31, 'Cryptosporidium parvum', NULL, 'Sporozoan', 'Gliding', 'Apical complex', 'Sexual and asexual cycles', 'Oocyst, sporozoite, trophozoite, merozoite, gametes', 9.1, 'Primary pathogen', 'Nitazoxanide (limited effectiveness)', 'Causes cryptosporidiosis, a diarrheal disease. Resistant to chlorine disinfection.', 'Major cause of waterborne disease outbreaks'),
(32, 'Toxoplasma gondii', 'Toxoplasma', 'Sporozoan', 'Gliding', 'Apical complex, conoid', 'Sexual cycle in cats, asexual elsewhere', 'Tachyzoite, bradyzoite, sporozoite', 65.0, 'Primary pathogen', 'Pyrimethamine with sulfadiazine', 'Causes toxoplasmosis. Can infect most warm-blooded animals but reproduces sexually only in cats.', 'Can cross the placenta and blood-brain barrier'),
(33, 'Entamoeba histolytica', 'Dysentery amoeba', 'Amoeboid', 'Pseudopodia', 'Single nucleus, no mitochondria', 'Binary fission', 'Trophozoite, cyst', 20.0, 'Primary pathogen', 'Metronidazole followed by paromomycin', 'Causes amoebiasis, including amoebic dysentery and liver abscesses.', 'Transmitted through fecal-oral route');

-- Enhanced Cyanobacteria data
INSERT INTO Cyanobacteria (taxonomy_id, scientific_name, common_name, morphology, nitrogen_fixation, toxin_production, toxin_types, photosynthetic_pigments, genome_size_mbp, ecological_importance, bloom_formation, description, notes) VALUES
(34, 'Anabaena', 'Water bloom', 'Filamentous', TRUE, TRUE, 'Anatoxin-a, microcystins', 'Chlorophyll a, phycocyanin, allophycocyanin', 5.4, 'Nitrogen fixation in aquatic ecosystems and rice paddies', TRUE, 'Forms specialized cells called heterocysts for nitrogen fixation. Can form toxic blooms in freshwater.', 'Some species are used as biofertilizers'),
(35, 'Nostoc', 'Witch''s butter', 'Filamentous', TRUE, FALSE, NULL, 'Chlorophyll a, phycocyanin, allophycocyanin', 9.0, 'Nitrogen fixation, soil stability', FALSE, 'Forms gelatinous colonies. Found in diverse environments from aquatic to terrestrial.', 'Some species are edible and used in traditional dishes'),
(36, 'Microcystis', 'Blue-green algae', 'Colonial', FALSE, TRUE, 'Microcystins', 'Chlorophyll a, phycocyanin', 5.8, 'Primary producer in aquatic ecosystems', TRUE, 'Forms harmful algal blooms in nutrient-rich freshwater. Produces hepatotoxins.', 'Major cause of water quality issues worldwide'),
(37, 'Oscillatoria', 'Pond scum', 'Filamentous', FALSE, TRUE, 'Anatoxin-a, saxitoxins', 'Chlorophyll a, phycocyanin, phycoerythrin', 6.5, 'Primary producer in aquatic ecosystems', TRUE, 'Forms mats in freshwater and marine environments. Shows gliding motility.', 'Can survive in extreme environments including hot springs'),
(38, 'Synechococcus', NULL, 'Unicellular', FALSE, FALSE, NULL, 'Chlorophyll a, phycocyanin, phycoerythrin', 2.7, 'Major contributor to global primary production in oceans', FALSE, 'Abundant marine cyanobacterium. Important in carbon and nitrogen cycles.', 'One of the smallest photosynthetic organisms');

-- Enhanced Plankton data
INSERT INTO Plankton (taxonomy_id, scientific_name, common_name, type, size_range, trophic_level, season_of_abundance, bloom_formation, ecological_importance, toxin_production, toxin_types, description, notes) VALUES
(39, 'Thalassiosira pseudonana', 'Diatom', 'Phytoplankton', '2-20 μm', 'Primary producer', 'Spring', TRUE, 'Major contributor to marine primary production and carbon sequestration', FALSE, NULL, 'Model organism for diatom research. Has silica cell wall.', 'First diatom to have its genome sequenced'),
(40, 'Alexandrium fundyense', 'Red tide dinoflagellate', 'Phytoplankton', '25-45 μm', 'Primary producer', 'Summer', TRUE, 'Primary producer in marine ecosystems', TRUE, 'Saxitoxins', 'Causes harmful algal blooms known as red tides. Produces toxins that cause paralytic shellfish poisoning.', 'Major cause of shellfish harvest closures'),
(41, 'Emiliania huxleyi', 'Coccolithophore', 'Phytoplankton', '5-10 μm', 'Primary producer', 'Summer', TRUE, 'Major contributor to oceanic calcium carbonate production', FALSE, NULL, 'Covered with calcium carbonate plates called coccoliths. Significant role in carbon and sulfur cycles.', 'Forms massive blooms visible from space'),
(42, 'Calanus finmarchicus', 'Copepod', 'Zooplankton', '2-4 mm', 'Primary consumer', 'Spring-Summer', FALSE, 'Key link in marine food web, transferring energy from phytoplankton to higher trophic levels', FALSE, NULL, 'Dominant zooplankton species in North Atlantic. Important food source for fish.', 'Undergoes vertical migration in water column'),
(43, 'Coscinodiscus wailesii', 'Giant diatom', 'Phytoplankton', '200-500 μm', 'Primary producer', 'Winter-Spring', TRUE, 'Significant contributor to primary production due to large size', FALSE, NULL, 'Large centric diatom with intricate silica cell wall. Can form massive blooms.', 'Invasive species in some regions');

-- Create sample diseases
INSERT INTO Diseases (disease_name, causative_agent_type, causative_agent_id, transmission_method, symptoms, diagnosis_method, treatment, prevention, geographical_distribution, mortality_rate, notes) VALUES
('Cholera', 'Bacteria', 9, 'Contaminated water and food', 'Severe watery diarrhea, vomiting, dehydration', 'Stool culture, rapid tests', 'Oral or intravenous rehydration, antibiotics', 'Clean water, sanitation, cholera vaccines', 'Southeast Asia, Africa, parts of Middle East and South America', 'Up to 50% if untreated, <1% with proper treatment', 'Caused by the bacterium Vibrio cholerae producing cholera toxin'),
('Tuberculosis', 'Bacteria', 8, 'Airborne droplets from coughs and sneezes', 'Chronic cough, fever, night sweats, weight loss', 'Sputum microscopy, culture, molecular tests', 'Multi-drug antibiotic regimen for 6-9 months', 'BCG vaccine, early detection and treatment', 'Worldwide, highest burden in Africa and Southeast Asia', 'Up to 45% if untreated, 5% with treatment', 'Increasing problem of multi-drug resistant TB'),
('Candidiasis', 'Fungi', 17, 'Endogenous infection, person-to-person', 'Mucosal infections, rash, oral thrush, vaginal discharge', 'Microscopy, culture', 'Topical or systemic antifungals', 'Good hygiene, controlling underlying conditions', 'Worldwide', '<1% except in severe immunocompromised cases', 'Common opportunistic infection in HIV/AIDS patients'),
('Malaria', 'Protozoa', 29, 'Female Anopheles mosquito bite', 'Fever, chills, headache, vomiting, fatigue', 'Blood smear microscopy, rapid diagnostic tests', 'Antimalarial drugs', 'Mosquito nets, insect repellent, antimalarial prophylaxis, vector control', 'Tropical and subtropical regions, especially sub-Saharan Africa', '0.3% overall, up to 20% for P. falciparum if untreated', 'Plasmodium falciparum causes most severe form');

-- Create sample enzymes
INSERT INTO Enzymes_Produced (enzyme_name, enzyme_function, industrial_use, medical_use, optimum_temperature, optimum_pH) VALUES
('Amylase', 'Hydrolyzes starch into sugars', 'Brewing, baking, textile desizing, paper industry', 'Digestive aid, pancreatic insufficiency treatment', 70.0, 6.5),
('Protease', 'Breaks down proteins into peptides and amino acids', 'Detergents, leather processing, meat tenderizing', 'Digestive aid, wound debridement', 60.0, 7.5),
('Lipase', 'Hydrolyzes fats into fatty acids and glycerol', 'Detergents, biodiesel production, food processing', 'Digestive aid, cystic fibrosis treatment', 37.0, 8.0),
('Cellulase', 'Breaks down cellulose into glucose', 'Textile processing, paper recycling, biofuel production', 'Research tool in glycobiology', 50.0, 5.0),
('Lactase', 'Hydrolyzes lactose into glucose and galactose', 'Dairy industry, lactose-free products', 'Lactose intolerance treatment', 37.0, 6.5);

-- Sample antimicrobial compounds
INSERT INTO Antimicrobial_Compounds (compound_name, chemical_class, mechanism_of_action, spectrum_of_activity, discovery_year, discovered_by, clinical_use, resistance_mechanisms) VALUES
('Penicillin G', 'Beta-lactam', 'Inhibits cell wall synthesis by binding to PBPs', 'Narrow spectrum: mainly Gram-positive bacteria', 1928, 1, 'Treatment of streptococcal, staphylococcal, and pneumococcal infections', 'Beta-lactamase production, altered PBPs, reduced permeability'),
('Streptomycin', 'Aminoglycoside', 'Binds to 30S ribosomal subunit inhibiting protein synthesis', 'Broad spectrum: many Gram-negative and some Gram-positive bacteria', 1943, 7, 'Tuberculosis treatment (in combination), plague, tularemia', 'Ribosomal mutations, reduced uptake, enzymatic modification'),
('Amphotericin B', 'Polyene', 'Binds to ergosterol disrupting fungal cell membrane', 'Broad spectrum: many fungi and some parasites', 1956, NULL, 'Severe systemic fungal infections', 'Altered membrane sterol composition, biofilm formation');

-- Sample genetic sequences
INSERT INTO Genetic_Sequences (microorganism_type, microorganism_id, sequence_type, accession_number, sequence_length, gc_content, sequencing_method, sequencing_date, notes) VALUES
('Bacteria', 1, '16S rRNA', 'J01859', 1541, 54.8, 'Sanger sequencing', '1978-05-15', 'First 16S rRNA sequence of E. coli'),
('Bacteria', 8, 'Genome', 'NC_000962', 4411532, 65.6, 'Whole genome shotgun', '1998-06-24', 'Reference genome of H37Rv strain'),
('Fungi', 14, 'Genome', 'NC_001133', 12157105, 38.3, 'Whole genome shotgun', '1996-04-30', 'First eukaryotic genome sequenced'),
('Protozoa', 29, 'Genome', 'NC_004325', 23264338, 19.4, 'Whole genome shotgun', '2002-10-03', '3D7 strain reference genome');

-- Create a view for microbial pathogens
CREATE VIEW Pathogenic_Microorganisms AS
SELECT 'Bacteria' as organism_type, b.bacteria_id as organism_id, b.scientific_name, b.common_name, b.pathogenicity, 
       t.phylum, t.class, t.taxonomic_order, t.family, t.genus
FROM Bacteria b
JOIN Taxonomy t ON b.taxonomy_id = t.taxonomy_id
WHERE b.pathogenicity IN ('Primary pathogen', 'Opportunistic pathogen')
UNION
SELECT 'Fungi' as organism_type, f.fungi_id as organism_id, f.scientific_name, f.common_name, f.pathogenicity,
       t.phylum, t.class, t.taxonomic_order, t.family, t.genus
FROM Fungi f
JOIN Taxonomy t ON f.taxonomy_id = t.taxonomy_id
WHERE f.pathogenicity IN ('Human pathogen', 'Animal pathogen', 'Plant pathogen')
UNION
SELECT 'Protozoa' as organism_type, p.protozoa_id as organism_id, p.scientific_name, p.common_name, p.pathogenicity,
       t.phylum, t.class, t.taxonomic_order, t.family, t.genus
FROM Protozoa p
JOIN Taxonomy t ON p.taxonomy_id = t.taxonomy_id
WHERE p.pathogenicity = 'Primary pathogen';

-- Create a view for microorganisms with industrial applications
CREATE VIEW Industrial_Microorganisms AS
SELECT 'Bacteria' as organism_type, b.scientific_name, ia.application_name, ia.industry, bia.commercial_importance
FROM Bacteria b
JOIN Bacteria_Industrial_Applications bia ON b.bacteria_id = bia.bacteria_id
JOIN Industrial_Applications ia ON bia.application_id = ia.application_id
UNION
SELECT 'Fungi' as organism_type, f.scientific_name, ia.application_name, ia.industry, fia.commercial_importance
FROM Fungi f
JOIN Fungi_Industrial_Applications fia ON f.fungi_id = fia.fungi_id
JOIN Industrial_Applications ia ON fia.application_id = ia.application_id
UNION
SELECT 'Cyanobacteria' as organism_type, c.scientific_name, ia.application_name, ia.industry, cia.commercial_importance
FROM Cyanobacteria c
JOIN Cyanobacteria_Industrial_Applications cia ON c.cyanobacteria_id = cia.cyanobacteria_id
JOIN Industrial_Applications ia ON cia.application_id = ia.application_id;

-- Create a view for habitat distribution
CREATE VIEW Habitat_Distribution AS
SELECT h.habitat_name, 
       COUNT(DISTINCT bh.bacteria_id) as bacteria_count,
       COUNT(DISTINCT fh.fungi_id) as fungi_count,
       COUNT(DISTINCT ph.protozoa_id) as protozoa_count,
       COUNT(DISTINCT ch.cyanobacteria_id) as cyanobacteria_count,
       COUNT(DISTINCT plh.plankton_id) as plankton_count
FROM Habitats h
LEFT JOIN Bacteria_Habitats bh ON h.habitat_id = bh.habitat_id
LEFT JOIN Fungi_Habitats fh ON h.habitat_id = fh.habitat_id
LEFT JOIN Protozoa_Habitats ph ON h.habitat_id = ph.habitat_id
LEFT JOIN Cyanobacteria_Habitats ch ON h.habitat_id = ch.habitat_id
LEFT JOIN Plankton_Habitats plh ON h.habitat_id = plh.habitat_id
GROUP BY h.habitat_name
ORDER BY (bacteria_count + fungi_count + protozoa_count + cyanobacteria_count + plankton_count) DESC;

-- Sample Queries

-- Query 1: Find all bacteria that produce enzymes with commercial importance
SELECT b.scientific_name, b.common_name, e.enzyme_name, e.industrial_use
FROM Bacteria b
JOIN Bacteria_Industrial_Applications bia ON b.bacteria_id = bia.bacteria_id
JOIN Industrial_Applications ia ON bia.application_id = ia.application_id
JOIN Microorganism_Enzymes me ON me.microorganism_id = b.bacteria_id AND me.microorganism_type = 'Bacteria'
JOIN Enzymes_Produced e ON me.enzyme_id = e.enzyme_id
WHERE bia.commercial_importance IN ('High', 'Medium')
ORDER BY b.scientific_name;

-- Query 2: Find all microorganisms that live in human gut and their roles
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
WHERE h.habitat_name = 'Human intestines' AND (b.scientific_name IS NOT NULL OR f.scientific_name IS NOT NULL OR p.scientific_name IS NOT NULL)
ORDER BY organism_type, scientific_name;

-- Query 3: Find pathogens that have developed drug resistance
SELECT 
    CASE 
        WHEN b.bacteria_id IS NOT NULL THEN 'Bacteria'
        WHEN f.fungi_id IS NOT NULL THEN 'Fungi'
        WHEN p.protozoa_id IS NOT NULL THEN 'Protozoa'
    END AS organism_type,
    COALESCE(b.scientific_name, f.scientific_name, p.scientific_name) AS scientific_name,
    COALESCE(b.pathogenicity, f.pathogenicity, p.pathogenicity) AS pathogenicity,
    COALESCE(b.antibiotic_resistance, f.antifungal_resistance, p.treatment_options) AS resistance_profile,
    d.disease_name
FROM Diseases d
LEFT JOIN Microorganism_Diseases md ON d.disease_id = md.disease_id
LEFT JOIN Bacteria b ON md.microorganism_type = 'Bacteria' AND md.microorganism_id = b.bacteria_id
LEFT JOIN Fungi f ON md.microorganism_type = 'Fungi' AND md.microorganism_id = f.fungi_id
LEFT JOIN Protozoa p ON md.microorganism_type = 'Protozoa' AND md.microorganism_id = p.protozoa_id
WHERE (
    (b.antibiotic_resistance IS NOT NULL AND b.antibiotic_resistance LIKE '%resistant%') OR
    (f.antifungal_resistance IS NOT NULL AND f.antifungal_resistance LIKE '%resistant%') OR
    (p.treatment_options IS NOT NULL AND p.treatment_options LIKE '%resistance%')
)
ORDER BY organism_type, scientific_name;

-- Query 4: Find microorganisms with medical applications
SELECT 'Bacteria' as organism_type, b.scientific_name, ma.application_name, ma.development_stage, bma.effectiveness
FROM Bacteria b
JOIN Bacteria_Medical_Applications bma ON b.bacteria_id = bma.bacteria_id
JOIN Medical_Applications ma ON bma.application_id = ma.application_id
UNION
SELECT 'Fungi' as organism_type, f.scientific_name, ma.application_name, ma.development_stage, fma.effectiveness
FROM Fungi f
JOIN Fungi_Medical_Applications fma ON f.fungi_id = fma.fungi_id
JOIN Medical_Applications ma ON fma.application_id = ma.application_id
UNION
SELECT 'Protozoa' as organism_type, p.scientific_name, ma.application_name, ma.development_stage, NULL as effectiveness
FROM Protozoa p
JOIN Protozoa_Medical_Applications pma ON p.protozoa_id = pma.protozoa_id
JOIN Medical_Applications ma ON pma.application_id = ma.application_id
ORDER BY application_name, organism_type;

-- Query 5: Analyze environmental distribution of toxin-producing microorganisms
SELECT 
    CASE 
        WHEN cb.cyanobacteria_id IS NOT NULL THEN 'Cyanobacteria'
        WHEN pl.plankton_id IS NOT NULL THEN 'Plankton'
    END AS organism_type,
    COALESCE(cb.scientific_name, pl.scientific_name) AS scientific_name,
    h.habitat_name,
    COALESCE(cb.toxin_types, pl.toxin_types) AS toxin_types,
    COALESCE(cb.bloom_formation, pl.bloom_formation) AS forms_blooms
FROM Habitats h
LEFT JOIN Cyanobacteria_Habitats cbh ON h.habitat_id = cbh.habitat_id
LEFT JOIN Cyanobacteria cb ON cbh.cyanobacteria_id = cb.cyanobacteria_id AND cb.toxin_production = TRUE
LEFT JOIN Plankton_Habitats plh ON h.habitat_id = plh.habitat_id
LEFT JOIN Plankton pl ON plh.plankton_id = pl.plankton_id AND pl.toxin_production = TRUE
WHERE (cb.toxin_production = TRUE OR pl.toxin_production = TRUE)
AND h.habitat_name LIKE '%water%'
ORDER BY h.habitat_name, organism_type;

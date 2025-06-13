# Comprehensive Microorganisms Database
**Author**: Arman Shaikh  
**passport ID**: Y5625646  

A sophisticated relational database system designed to catalog and analyze diverse microorganisms including bacteria, fungi, protozoa, cyanobacteria, and plankton.

## Project Overview

This database serves as a scientific information repository that models complex relationships between microorganisms, their habitats, applications, and ecological roles. It demonstrates advanced database design principles applied to scientific data.

![Database Schema Overview](https://via.placeholder.com/800x400?text=Database+Schema+Diagram)

## Key Features

- **Complete Taxonomy System**: Full classification hierarchy from domain to genus
- **Detailed Scientific Metadata**: Morphological features, optimal growth conditions, genome sizes
- **Environmental Context**: Habitat relationships across 19 diverse environments
- **Application Tracking**: Medical and industrial applications of microorganisms
- **Advanced Analysis**: Custom views and queries for scientific insights

## Database Structure

The system comprises over 30 interconnected tables including:

- **Core microorganism tables**: Bacteria, Fungi, Protozoa, Cyanobacteria, Plankton
- **Classification tables**: Taxonomy, Researchers
- **Environmental tables**: Habitats and relationship mappings
- **Application tables**: Medical, Industrial
- **Scientific data**: Genetic sequences, Enzymes, Antimicrobial compounds

## Example Query

```sql
-- Find bacteria that produce commercially important enzymes
SELECT b.scientific_name, e.enzyme_name, e.industrial_use
FROM Bacteria b
JOIN Microorganism_Enzymes me ON me.microorganism_id = b.bacteria_id 
JOIN Enzymes_Produced e ON me.enzyme_id = e.enzyme_id
WHERE me.production_efficiency = 'High'
ORDER BY b.scientific_name;

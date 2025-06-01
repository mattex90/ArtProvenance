# ArtProvenance: Fine Art Authentication and Provenance Platform

ArtProvenance is a decentralized art registry built on blockchain technology that enables curators and collectors to authenticate, catalogue, and track fine artworks with verifiable provenance.

## Overview

ArtProvenance creates a trusted platform for art professionals and collectors to document and preserve artistic heritage. The platform allows curators to register artworks with verifiable details like creation year and authenticity status, establishing provenance and authenticity for valuable fine art collections.

## Features

- Catalogue fine artworks with detailed information (title, attribution, medium, authenticity)
- Document creation year for accurate dating and art historical context
- Manage exhibition status for collection inventory
- Browse artworks by medium, authenticity level, era, or curator
- Transparent ownership tracking and artistic provenance

## Contract Functions

### Public Functions

- `catalogue-artwork`: Register a fine artwork in the provenance registry
- `deaccession-artwork`: Remove an artwork from active collection
- `get-artwork`: Retrieve details about a specific artwork
- `get-curator`: Get the curator who catalogued a specific artwork

### Constants

- Minimum creation year validation (1400 - Renaissance era)
- Validation for artistic mediums and authenticity levels
- Error codes for various failure scenarios

## Data Structure

Each artwork entry contains:
- Curator information (principal)
- Artwork title (string)
- Attribution and provenance documentation (string)
- Medium classification
- Authenticity assessment
- Exhibition status
- Creation year

## Getting Started

To interact with the ArtProvenance registry:

1. Deploy the contract to a Stacks blockchain node
2. Call the contract functions using a compatible wallet or Clarity development environment
3. Catalogue your fine artworks to establish provenance
4. Browse registered artworks from other curators and institutions

## Future Development

- Implement artwork trading functionality
- Add expert authentication system
- Create artistic valuation and appreciation tracking
- Develop virtual gallery showcases and exhibition management
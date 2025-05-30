# FlavorFactory - Recipe Management App

## Overview
FlavorFactory is an iOS and iPadOS application designed to manage recipes and guide users through the cooking process step by step. The app focuses on maintaining a single source of truth for ingredients and providing a seamless cooking experience.

## Core Features

### Recipe Management
- Recipe creation and editing
- Categorization system
- Portion scaling
- Rating system (1-5 stars, 0.5 step increments)

### Recipe Structure
1. **Basic Information**
   - Title
   - Category (Vegetarian, Vegan, Poultry, etc.)
   - Number of portions
   - Rating (1-5 stars, 0.5 increments)

2. **Ingredients**
   - Title
   - Details (e.g., "Paprika - 0.5" or "Onion - 1")
   - Availability status (whether typically available at home)
   - Single source of truth implementation
   - Automatic calculation from steps

3. **Cooking Steps**
   - Step description
   - Associated ingredients
   - Optional step image
   - Ingredient references (linked to main ingredient list)

### Key Technical Requirements

#### Data Model
- Centralized ingredient management
- Relationship between steps and ingredients
- Portion scaling calculations
- Default portion adjustment after cooking

#### User Interface
- Step-by-step cooking guide
- Ingredient overview
- Portion scaling interface
- Post-cooking portion adjustment

## Technical Considerations

### Data Persistence
- SwiftData as primary storage solution
- CloudKit integration for sync across devices
- Local-first architecture with cloud backup
- Offline capability with sync when online

### Import/Export
- JSON-based recipe format
- Import functionality for recipe sharing
- Export functionality for backup and sharing
- Validation of imported data
- Version control for recipe format

### Single Source of Truth
- Ingredients are stored only once in the recipe
- Steps reference ingredients from the main list
- Automatic calculation of total ingredients from steps
- Prevention of duplicate ingredient entries

### Portion Management
- Dynamic scaling of ingredients based on portion changes
- Post-cooking portion adjustment
- Preservation of original recipe proportions
- Update of default portions based on actual yield

### Data Integrity
- Validation of ingredient references
- Consistency checks between steps and ingredient list
- Prevention of orphaned ingredient references

## Future Considerations
- Recipe sharing capabilities
- Shopping list generation
- Meal planning features
- Integration with smart kitchen devices
- Nutritional information
- Cooking timer integration
- Voice control for hands-free cooking

## Development Priorities
1. Core recipe management
2. SwiftData implementation with CloudKit
3. Single source of truth implementation
4. Portion scaling system
5. Step-by-step cooking guide
6. Post-cooking adjustments
7. JSON Import/Export functionality
8. Additional features (sharing, shopping lists, etc.)

## Data Model Considerations

### SwiftData Models
- Recipe
  - Basic information (title, category, portions, rating)
  - CloudKit metadata
  - Version information
  - Metadata
    - Creation date
    - Last modified date
    - Last cooked date
    - Cooking history (array of dates)
    - Personal notes
    - Tags
    - Favorite status
    - Source (original source of the recipe)
    - Difficulty level
    - Preparation time
    - Cooking time
    - Total time
- Ingredient
  - Title and details
  - Availability status
  - Reference counting for steps
- Step
  - Description
  - Image reference
  - Ingredient references
  - Order information

### JSON Schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "https://flavorfactory.app/schemas/recipe/v1.0",
  "title": "FlavorFactory Recipe",
  "type": "object",
  "required": ["version", "recipe"],
  "properties": {
    "version": { "type": "string" },
    "recipe": { "$ref": "#/$defs/Recipe" }
  },
  "$defs": {
    "Recipe": {
      "type": "object",
      "required": ["title", "course", "dietaryType", "portions", "steps"],
      "properties": {
        "title": { "type": "string", "minLength": 1 },
        "course": {
          "type": "string",
          "enum": [
            "main", "dessert", "appetizer", "soup", "salad", "side", "breakfast", "snack", "other"
          ]
        },
        "dietaryType": {
          "type": "string",
          "enum": [
            "vegetarian", "vegan", "pescatarian", "omnivore", "other"
          ]
        },
        "portions": { "type": "integer", "minimum": 1 },
        "rating": { "type": ["number", "null"], "minimum": 1, "maximum": 5, "multipleOf": 0.5 },
        "creationDate": { "type": "string", "format": "date-time" },
        "lastModifiedDate": { "type": "string", "format": "date-time" },
        "lastCookedDate": { "type": ["string", "null"], "format": "date-time" },
        "cookingHistory": {
          "type": "array",
          "items": { "type": "string", "format": "date-time" }
        },
        "notes": { "type": ["string", "null"] },
        "tags": {
          "type": "array",
          "items": { "type": "string" }
        },
        "isFavorite": { "type": "boolean", "default": false },
        "source": { "type": ["string", "null"] },
        "difficulty": {
          "type": ["string", "null"],
          "enum": ["easy", "medium", "hard", null]
        },
        "preparationTime": { "type": ["integer", "null"], "minimum": 0 },
        "cookingTime": { "type": ["integer", "null"], "minimum": 0 },
        "steps": {
          "type": "array",
          "minItems": 1,
          "items": { "$ref": "#/$defs/Step" }
        }
      }
    },
    "Step": {
      "type": "object",
      "required": ["text", "order"],
      "properties": {
        "text": { "type": "string", "minLength": 1 },
        "image": { "type": ["string", "null"] },
        "order": { "type": "integer", "minimum": 1 },
        "ingredients": {
          "type": "array",
          "items": { "$ref": "#/$defs/Ingredient" }
        }
      }
    },
    "Ingredient": {
      "type": "object",
      "required": ["title", "amount"],
      "properties": {
        "title": { "type": "string", "minLength": 1 },
        "amount": { "type": "number" },
        "unit": {
          "type": ["string", "null"],
          "enum": [
            "g", "ml", "tsp", "tbsp", "piece", "cup", "can", "pinch", 
            "slice", "bunch", "pack", "jar", "cm", "l", "kg", "dash", null
          ]
        },
        "available": { "type": "boolean", "default": false }
      }
    }
  }
}
```

**Unit Mapping (English to German):**
- g → g
- ml → ml
- tsp → TL (Teelöffel)
- tbsp → EL (Esslöffel)
- piece → Stück
- cup → Tasse
- can → Dose
- pinch → Prise
- slice → Scheibe
- bunch → Bund
- pack → Päckchen
- jar → Glas
- cm → cm
- l → l
- kg → kg
- dash → Spritzer

## User Experience Features

### Recipe History
- Track when recipes were cooked
- View cooking frequency
- Filter recipes by last cooked date
- Sort by cooking frequency

### Recipe Notes
- Add personal notes to recipes
- Document modifications made
- Record tips and tricks
- Note serving suggestions

### Recipe Organization
- Tag system for better organization
- Favorite recipes for quick access
- Difficulty level tracking
- Time tracking for better planning

### Recipe Analytics
- Most cooked recipes
- Cooking patterns
- Time spent cooking
- Favorite categories 
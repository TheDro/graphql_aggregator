# Ingredient Model Implementation Plan

## Overview
We want to create an `Ingredient` model that has a many-to-many association with the `Product` model. These ingredients will represent physical components used in product manufacturing, such as screens, magnets, electronic components, etc.

## Database Schema

### Ingredients Table
| Column Name    | Data Type      | Constraints     | Description                     |
|----------------|----------------|----------------|---------------------------------|
| id             | bigint         | PK, not null   | Primary key                     |
| name           | string         | not null, unique| Name of the ingredient          |
| weight         | decimal(10,2)  |                | weight of one of the ingredient |
| created_at     | datetime       | not null       | Timestamp of creation           |
| updated_at     | datetime       | not null       | Timestamp of last update        |

### Product Ingredients (Join Table)
| Column Name    | Data Type      | Constraints     | Description                                     |
|----------------|----------------|----------------|-------------------------------------------------|
| id             | bigint         | PK, not null   | Primary key                                     |
| product_id     | bigint         | FK, not null   | Foreign key to products table                   |
| ingredient_id  | bigint         | FK, not null   | Foreign key to ingredients table                |
| created_at     | datetime       | not null       | Timestamp of creation                           |
| updated_at     | datetime       | not null       | Timestamp of last update                        |



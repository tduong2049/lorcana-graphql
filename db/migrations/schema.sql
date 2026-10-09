CREATE TYPE ink AS ENUM (
    'AMBER',
    'AMETHYST',
    'EMERALD',
    'RUBY',
    'SAPPHIRE',
    'STEEL'
);

CREATE TYPE rarity AS ENUM (
    'COMMON',
    'UNCOMMON',
    'RARE',
    'SUPER_RARE',
    'LEGENDARY',
    'EPIC',
    'ENCHANTED',
    'ICONIC'
);

CREATE TYPE classification AS ENUM (
    'ITEM',
    'ACTION',
    'SONG',
    'LOCATION',

    'STORYBORN',
    'DREAMBORN',
    'FLOODBORN',

    'HERO',
    'VILLAIN',
    'ALLY',

    'ALIEN',
    'CAPTAIN',
    'HUNNY',
    'HYPERIA_CITY',
    'KING',
    'KNIGHT',
    'MADRIGAL',
    'MENTOR',
    'MONSTER',
    'PRINCE',
    'PRINCESS',
    'QUEEN',
    'RED_PANDA',
    'SORCERER',
    'TEAM',
    'TOY',
    'VINELING',

    'OTHER'
);

CREATE TABLE characters (
    id uuid PRIMARY KEY DEFAULT uuidv7(),
    name text NOT NULL,
    cost int NOT NULL CHECK (cost > 0),
    inkwell boolean NOT NULL,
    ink ink NOT NULL,
    classifications classification[] NOT NULL DEFAULT '{}',
    rarity rarity NOT NULL,
    set int NOT NULL CHECK (set > 0),
    number int NOT NULL CHECK (number > 0),
    
    version text NOT NULL,
    strength int NOT NULL CHECK (strength >= 0),
    willpower int NOT NULL CHECK (willpower >= 0),
    lore_value int NOT NULL CHECK (lore_value >= 0),

    UNIQUE (set, number)
);

CREATE TABLE actions (
    id uuid PRIMARY KEY DEFAULT uuidv7(),
    name text NOT NULL,
    cost int NOT NULL CHECK (cost > 0),
    inkwell boolean NOT NULL,
    ink ink NOT NULL,
    classifications classification[] NOT NULL DEFAULT '{}',
    rarity rarity NOT NULL,
    set int NOT NULL CHECK (set > 0),
    number int NOT NULL CHECK (number > 0),

    description text NOT NULL,
    sing_together_cost int CHECK (sing_together_cost > 0),

    UNIQUE (set, number)
);

CREATE TABLE locations (
    id uuid PRIMARY KEY DEFAULT uuidv7(),
    name text NOT NULL,
    cost int NOT NULL CHECK (cost > 0),
    inkwell boolean NOT NULL,
    ink ink NOT NULL,
    classifications classification[] NOT NULL DEFAULT '{}',
    rarity rarity NOT NULL,
    set int NOT NULL CHECK (set > 0),
    number int NOT NULL CHECK (number > 0),

    willpower int NOT NULL CHECK (willpower >= 0),
    lore_value int NOT NULL CHECK (lore_value >= 0),
    move_cost int NOT NULL CHECK (move_cost >= 0),

    UNIQUE (set, number)
);

CREATE TABLE abilities (
    id uuid PRIMARY KEY DEFAULT uuidv7(),
    name text NOT NULL,
    description text NOT NULL,
    keyword boolean NOT NULL DEFAULT false,

    UNIQUE (name, description)
);

CREATE TABLE character_abilities (
    character_id uuid NOT NULL REFERENCES characters (id) ON DELETE CASCADE,
    ability_id uuid NOT NULL REFERENCES abilities (id) ON DELETE RESTRICT,

    PRIMARY KEY (character_id, ability_id)
);

CREATE INDEX character_abilities_ability_id_idx ON character_abilities (ability_id);

CREATE TABLE location_abilities (
    location_id uuid NOT NULL REFERENCES locations (id) ON DELETE CASCADE,
    ability_id uuid NOT NULL REFERENCES abilities (id) ON DELETE RESTRICT,

    PRIMARY KEY (location_id, ability_id)
);

CREATE INDEX location_abilities_ability_id_idx ON location_abilities (ability_id);
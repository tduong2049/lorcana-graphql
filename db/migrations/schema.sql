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
    set_number int NOT NULL CHECK (set_number > 0),
    card_number int NOT NULL CHECK (card_number > 0),
    
    version text NOT NULL,
    strength int NOT NULL CHECK (strength >= 0),
    willpower int NOT NULL CHECK (willpower >= 0),
    lore_value int NOT NULL CHECK (lore_value >= 0),

    UNIQUE (set_number, card_number)
);
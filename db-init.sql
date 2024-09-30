-- Initial SQL setup for the database
CREATE TABLE IF NOT EXISTS Cocktails (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    glass_type VARCHAR(255),
    category VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Ingredients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Cocktail_Ingredients (
    id SERIAL PRIMARY KEY,
    cocktail_id INT REFERENCES Cocktails(id),
    ingredient_id INT REFERENCES Ingredients(id),
    quantity VARCHAR(255),
    measurement_unit VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Instructions (
    id SERIAL PRIMARY KEY,
    cocktail_id INT REFERENCES Cocktails(id),
    step_number INT,
    description TEXT
);

-- Insert Ingredients
INSERT INTO Ingredients (name) VALUES
('Angostura Bitters'),
('Aperol'),
('Black Pepper'),
('Campari'),
('Celery Salt'),
('Celery Stick'),
('Club Soda'),
('Cointreau'),
('Cola'),
('Cranberry Juice'),
('Dry Vermouth'),
('Egg White'),
('Gin'),
('Grenadine'),
('Lemon Juice'),
('Lemon Twist'),
('Lime Juice'),
('Lime Wedge'),
('Maraschino Cherry'),
('Mint Leaves'),
('Olive'),
('Orange Bitters'),
('Orange Juice'),
('Orange Twist'),
('Pineapple Juice'),
('Prosecco'),
('Salt'),
('Simple Syrup'),
('Soda Water'),
('Sugar'),
('Sweet Vermouth'),
('Tabasco Sauce'),
('Tequila'),
('Tomato Juice'),
('Tonic Water'),
('Triple Sec'),
('Vodka'),
('White Rum'),
('Whiskey'),
('Worcestershire Sauce');

-- Insert Cocktails
INSERT INTO Cocktails (name, description, glass_type, category) VALUES
('Mojito', 'A classic mojito.', 'Highball', 'Cocktail'),
('Martini', 'A classic martini.', 'Cocktail', 'Cocktail'),
('Margarita', 'A classic margarita.', 'Cocktail', 'Cocktail'),
('Old Fashioned', 'A classic old fashioned.', 'Old Fashioned', 'Cocktail'),
('Bloody Mary', 'A classic bloody mary.', 'Highball', 'Cocktail'),
('Negroni', 'A classic negroni.', 'Rocks', 'Cocktail'),
('Manhattan', 'A classic manhattan.', 'Cocktail', 'Cocktail'),
('Daiquiri', 'A classic daiquiri.', 'Cocktail', 'Cocktail'),
('Cosmopolitan', 'A classic cosmopolitan.', 'Cocktail', 'Cocktail'),
('Whiskey Sour', 'A classic whiskey sour.', 'Old Fashioned', 'Cocktail');

-- Insert for Mojito
INSERT INTO Cocktail_Ingredients (cocktail_id, ingredient_id, quantity, measurement_unit) VALUES
((SELECT id FROM Cocktails WHERE name='Mojito'), (SELECT id FROM Ingredients WHERE name='White Rum'), '2', 'oz'),
((SELECT id FROM Cocktails WHERE name='Mojito'), (SELECT id FROM Ingredients WHERE name='Lime Juice'), '1', 'oz'),
((SELECT id FROM Cocktails WHERE name='Mojito'), (SELECT id FROM Ingredients WHERE name='Mint Leaves'), '10', ''),
((SELECT id FROM Cocktails WHERE name='Mojito'), (SELECT id FROM Ingredients WHERE name='Soda Water'), '2', 'oz'),
((SELECT id FROM Cocktails WHERE name='Mojito'), (SELECT id FROM Ingredients WHERE name='Sugar'), '2', 'tsp');

INSERT INTO Instructions (cocktail_id, step_number, description) VALUES
((SELECT id FROM Cocktails WHERE name='Mojito'), 1, 'Muddle mint leaves with sugar and lime juice.'),
((SELECT id FROM Cocktails WHERE name='Mojito'), 2, 'Add rum and fill the glass with ice.'),
((SELECT id FROM Cocktails WHERE name='Mojito'), 3, 'Top up with soda water and garnish with mint sprig.');

-- Insert for Martini
INSERT INTO Cocktail_Ingredients (cocktail_id, ingredient_id, quantity, measurement_unit) VALUES
((SELECT id FROM Cocktails WHERE name='Martini'), (SELECT id FROM Ingredients WHERE name='Gin'), '2.5', 'oz'),
((SELECT id FROM Cocktails WHERE name='Martini'), (SELECT id FROM Ingredients WHERE name='Dry Vermouth'), '0.5', 'oz'),
((SELECT id FROM Cocktails WHERE name='Martini'), (SELECT id FROM Ingredients WHERE name='Olive'), '1', '');

INSERT INTO Instructions (cocktail_id, step_number, description) VALUES
((SELECT id FROM Cocktails WHERE name='Martini'), 1, 'Stir gin and vermouth with ice.'),
((SELECT id FROM Cocktails WHERE name='Martini'), 2, 'Strain into a chilled cocktail glass.'),
((SELECT id FROM Cocktails WHERE name='Martini'), 3, 'Garnish with an olive.');

-- Insert for Margarita
INSERT INTO Cocktail_Ingredients (cocktail_id, ingredient_id, quantity, measurement_unit) VALUES
((SELECT id FROM Cocktails WHERE name='Margarita'), (SELECT id FROM Ingredients WHERE name='Tequila'), '2', 'oz'),
((SELECT id FROM Cocktails WHERE name='Margarita'), (SELECT id FROM Ingredients WHERE name='Lime Juice'), '1', 'oz'),
((SELECT id FROM Cocktails WHERE name='Margarita'), (SELECT id FROM Ingredients WHERE name='Cointreau'), '1', 'oz'),
((SELECT id FROM Cocktails WHERE name='Margarita'), (SELECT id FROM Ingredients WHERE name='Salt'), '1', 'pinch');

INSERT INTO Instructions (cocktail_id, step_number, description) VALUES
((SELECT id FROM Cocktails WHERE name='Margarita'), 1, 'Shake ingredients with ice.'),
((SELECT id FROM Cocktails WHERE name='Margarita'), 2, 'Strain into a salt-rimmed glass filled with fresh ice.');

-- Insert for Old Fashioned
INSERT INTO Cocktail_Ingredients (cocktail_id, ingredient_id, quantity, measurement_unit) VALUES
((SELECT id FROM Cocktails WHERE name='Old Fashioned'), (SELECT id FROM Ingredients WHERE name='Whiskey'), '2', 'oz'),
((SELECT id FROM Cocktails WHERE name='Old Fashioned'), (SELECT id FROM Ingredients WHERE name='Simple Syrup'), '1', 'tsp'),
((SELECT id FROM Cocktails WHERE name='Old Fashioned'), (SELECT id FROM Ingredients WHERE name='Angostura Bitters'), '2', 'dashes'),
((SELECT id FROM Cocktails WHERE name='Old Fashioned'), (SELECT id FROM Ingredients WHERE name='Orange Bitters'), '1', 'dash'),
((SELECT id FROM Cocktails WHERE name='Old Fashioned'), (SELECT id FROM Ingredients WHERE name='Orange Twist'), '1', '');

INSERT INTO Instructions (cocktail_id, step_number, description) VALUES
((SELECT id FROM Cocktails WHERE name='Old Fashioned'), 1, 'Muddle bitters and simple syrup.'),
((SELECT id FROM Cocktails WHERE name='Old Fashioned'), 2, 'Add whiskey and ice, and stir.'),
((SELECT id FROM Cocktails WHERE name='Old Fashioned'), 3, 'Garnish with an orange twist.');

-- Insert for Bloody Mary
INSERT INTO Cocktail_Ingredients (cocktail_id, ingredient_id, quantity, measurement_unit) VALUES
((SELECT id FROM Cocktails WHERE name='Bloody Mary'), (SELECT id FROM Ingredients WHERE name='Vodka'), '1.5', 'oz'),
((SELECT id FROM Cocktails WHERE name='Bloody Mary'), (SELECT id FROM Ingredients WHERE name='Tomato Juice'), '3', 'oz'),
((SELECT id FROM Cocktails WHERE name='Bloody Mary'), (SELECT id FROM Ingredients WHERE name='Lemon Juice'), '0.5', 'oz'),
((SELECT id FROM Cocktails WHERE name='Bloody Mary'), (SELECT id FROM Ingredients WHERE name='Worcestershire Sauce'), '2', 'dashes'),
((SELECT id FROM Cocktails WHERE name='Bloody Mary'), (SELECT id FROM Ingredients WHERE name='Tabasco Sauce'), '2', 'dashes'),
((SELECT id FROM Cocktails WHERE name='Bloody Mary'), (SELECT id FROM Ingredients WHERE name='Celery Salt'), '1', 'pinch'),
((SELECT id FROM Cocktails WHERE name='Bloody Mary'), (SELECT id FROM Ingredients WHERE name='Black Pepper'), '1', 'pinch'),
((SELECT id FROM Cocktails WHERE name='Bloody Mary'), (SELECT id FROM Ingredients WHERE name='Celery Stick'), '1', '');

INSERT INTO Instructions (cocktail_id, step_number, description) VALUES
((SELECT id FROM Cocktails WHERE name='Bloody Mary'), 1, 'Combine ingredients with ice and stir.'),
((SELECT id FROM Cocktails WHERE name='Bloody Mary'), 2, 'Strain into a glass with fresh ice.'),
((SELECT id FROM Cocktails WHERE name='Bloody Mary'), 3, 'Garnish with a celery stick.');

-- Insert for Negroni
INSERT INTO Cocktail_Ingredients (cocktail_id, ingredient_id, quantity, measurement_unit) VALUES
((SELECT id FROM Cocktails WHERE name='Negroni'), (SELECT id FROM Ingredients WHERE name='Gin'), '1', 'oz'),
((SELECT id FROM Cocktails WHERE name='Negroni'), (SELECT id FROM Ingredients WHERE name='Sweet Vermouth'), '1', 'oz'),
((SELECT id FROM Cocktails WHERE name='Negroni'), (SELECT id FROM Ingredients WHERE name='Campari'), '1', 'oz'),
((SELECT id FROM Cocktails WHERE name='Negroni'), (SELECT id FROM Ingredients WHERE name='Orange Twist'), '1', '');

INSERT INTO Instructions (cocktail_id, step_number, description) VALUES
((SELECT id FROM Cocktails WHERE name='Negroni'), 1, 'Stir ingredients with ice.'),
((SELECT id FROM Cocktails WHERE name='Negroni'), 2, 'Strain into a rocks glass over ice.'),
((SELECT id FROM Cocktails WHERE name='Negroni'), 3, 'Garnish with an orange twist.');

-- Insert for Manhattan
INSERT INTO Cocktail_Ingredients (cocktail_id, ingredient_id, quantity, measurement_unit) VALUES
((SELECT id FROM Cocktails WHERE name='Manhattan'), (SELECT id FROM Ingredients WHERE name='Whiskey'), '2', 'oz'),
((SELECT id FROM Cocktails WHERE name='Manhattan'), (SELECT id FROM Ingredients WHERE name='Sweet Vermouth'), '1', 'oz'),
((SELECT id FROM Cocktails WHERE name='Manhattan'), (SELECT id FROM Ingredients WHERE name='Angostura Bitters'), '2', 'dashes'),
((SELECT id FROM Cocktails WHERE name='Manhattan'), (SELECT id FROM Ingredients WHERE name='Maraschino Cherry'), '1', '');

INSERT INTO Instructions (cocktail_id, step_number, description) VALUES
((SELECT id FROM Cocktails WHERE name='Manhattan'), 1, 'Stir whiskey, vermouth, and bitters with ice.'),
((SELECT id FROM Cocktails WHERE name='Manhattan'), 2, 'Strain into a chilled cocktail glass.'),
((SELECT id FROM Cocktails WHERE name='Manhattan'), 3, 'Garnish with a maraschino cherry.');

-- Insert for Daiquiri
INSERT INTO Cocktail_Ingredients (cocktail_id, ingredient_id, quantity, measurement_unit) VALUES
((SELECT id FROM Cocktails WHERE name='Daiquiri'), (SELECT id FROM Ingredients WHERE name='White Rum'), '2', 'oz'),
((SELECT id FROM Cocktails WHERE name='Daiquiri'), (SELECT id FROM Ingredients WHERE name='Lime Juice'), '1', 'oz'),
((SELECT id FROM Cocktails WHERE name='Daiquiri'), (SELECT id FROM Ingredients WHERE name='Simple Syrup'), '0.75', 'oz');

INSERT INTO Instructions (cocktail_id, step_number, description) VALUES
((SELECT id FROM Cocktails WHERE name='Daiquiri'), 1, 'Shake ingredients with ice.'),
((SELECT id FROM Cocktails WHERE name='Daiquiri'), 2, 'Strain into a chilled cocktail glass.');

-- Insert for Cosmopolitan
INSERT INTO Cocktail_Ingredients (cocktail_id, ingredient_id, quantity, measurement_unit) VALUES
((SELECT id FROM Cocktails WHERE name='Cosmopolitan'), (SELECT id FROM Ingredients WHERE name='Vodka'), '1.5', 'oz'),
((SELECT id FROM Cocktails WHERE name='Cosmopolitan'), (SELECT id FROM Ingredients WHERE name='Triple Sec'), '1', 'oz'),
((SELECT id FROM Cocktails WHERE name='Cosmopolitan'), (SELECT id FROM Ingredients WHERE name='Cranberry Juice'), '1', 'oz'),
((SELECT id FROM Cocktails WHERE name='Cosmopolitan'), (SELECT id FROM Ingredients WHERE name='Lime Juice'), '0.5', 'oz');

INSERT INTO Instructions (cocktail_id, step_number, description) VALUES
((SELECT id FROM Cocktails WHERE name='Cosmopolitan'), 1, 'Shake ingredients with ice.'),
((SELECT id FROM Cocktails WHERE name='Cosmopolitan'), 2, 'Strain into a chilled cocktail glass.');

-- Insert for Whiskey Sour
INSERT INTO Cocktail_Ingredients (cocktail_id, ingredient_id, quantity, measurement_unit) VALUES
((SELECT id FROM Cocktails WHERE name='Whiskey Sour'), (SELECT id FROM Ingredients WHERE name='Whiskey'), '2', 'oz'),
((SELECT id FROM Cocktails WHERE name='Whiskey Sour'), (SELECT id FROM Ingredients WHERE name='Lemon Juice'), '0.75', 'oz'),
((SELECT id FROM Cocktails WHERE name='Whiskey Sour'), (SELECT id FROM Ingredients WHERE name='Simple Syrup'), '0.75', 'oz'),
((SELECT id FROM Cocktails WHERE name='Whiskey Sour'), (SELECT id FROM Ingredients WHERE name='Egg White'), '1', '');

INSERT INTO Instructions (cocktail_id, step_number, description) VALUES
((SELECT id FROM Cocktails WHERE name='Whiskey Sour'), 1, 'Shake ingredients without ice to emulsify egg white.'),
((SELECT id FROM Cocktails WHERE name='Whiskey Sour'), 2, 'Add ice and shake again.'),
((SELECT id FROM Cocktails WHERE name='Whiskey Sour'), 3, 'Strain into an old fashioned glass with ice.');


-- 1. Display all planets & their biomes. 

SELECT planet_name,
    biome
FROM dbo.nms_planets AS planets

-- 2. Find all planets with aggressive or Corrupted Sentinel Activity. Show planet name, biome, and senintel level. 

SELECT planet_name,
    biome,
    sentinel_level
FROM dbo.nms_planets
WHERE sentinel_level = 'Aggressive'
    OR sentinel_level = 'Corrupted'

-- 3. List ever yplanet name and the name of the start system it belogns to. 
-- Include planets that belong to systems in Elucid (galaxy id 1) only. 

SELECT DISTINCT(system_name),
    planet_name,
    biome
FROM dbo.nms_planets AS p
LEFT JOIN dbo.nms_star_systems AS ss
    ON p.system_id = ss.system_id
WHERE galaxy_id = 1;

-- Claude Assessment: Mostly Right - DISTINCT unnecessary. Each planet only appears once. 
-- Missing ORDER BY (not mentioned in request). Also included biome when not needed. Corrected query below: 

SELECT p.planet_name,
    s.system_name
FROM dbo.nms_planets AS p
LEFT JOIN dbo.nms_star_systems AS s
    ON p.system_id = s.system_id
WHERE galaxy_id = 1
ORDER BY s.system_name;

-- 4. Find all planets in Red star systems.
-- Show planet name, biome, and star color. 

SELECT p.planet_name,
    p.biome,
    s.star_color
FROM dbo.nms_planets AS p
LEFT JOIN dbo.nms_star_systems AS s
    ON p.system_id = s.system_id
WHERE s.star_color = 'Red';

-- 5. List every planet name, its star system name, and the galaxy it belongs to.
-- Only show planets in Lush galaxies.

SELECT p.planet_name,
    s.system_name,
    g.galaxy_name
FROM dbo.nms_planets AS p
JOIN dbo.nms_star_systems AS s
    ON p.system_id = s.system_id
JOIN dbo.nms_galaxies AS g
    ON s.galaxy_id = g.galaxy_id
    WHERE g.galaxy_type = 'Lush';

-- Struggling with the above. Only able to get one row to show up. Not sure why.

-- 6. Aggregation & GROUP BY. Count how many planets exist per biome type. Sort by highest count first. 

SELECT biome,
    COUNT(planet_name) AS planet_count
FROM dbo.nms_planets AS p
GROUP BY biome
ORDER BY COUNT(planet_name) DESC; 

-- Claude Input: ✅ Correct - only style recommendation is changing ORDER BY to reference planet count alias. 

SELECT biome,
    COUNT(planet_name) AS planet_count
FROM dbo.nms_planets AS p
GROUP BY biome
ORDER BY planet_count DESC; 

-- 7. For each star system, show the system name and total number of planets. Only include systems with 3+ planets. 

SELECT s.system_name,
    COUNT(p.planet_name) AS number_of_planets
FROM dbo.nms_star_systems AS s
LEFT JOIN dbo.nms_planets AS p
    ON s.system_id = p.system_id
GROUP BY s.system_name
HAVING COUNT(p.planet_name) >= 3;

-- 8. ANTI-JOIN - Find all star systems that have NO planets recorded in the planets table. 
-- Show the system name & galaxy_id. 

SELECT s.system_name,
    s.galaxy_id
FROM dbo.nms_star_systems AS s
LEFT JOIN dbo.nms_planets AS p
    ON s.system_id = p.system_id
WHERE p.system_id IS NULL;

-- Extra confused about WHERE condition for Anti-Join. If I need to find the number of systems 
-- with zero planets, does that mean I need to set the WHERE condition to focus on system_id, 
-- then see if any planets do not have that system_id? If so - how tf do I say that in SQL? 
-- Skipping and asking Claude for guidance (also feeling woozy/lightheaded/barely thinking straight.)

-- 9. For each galaxy, show the galaxy name and total number of planets across all systems. Sort by highest planet count first. 

SELECT g.galaxy_name,
    COUNT(p.planet_name) AS number_of_planets
FROM dbo.nms_galaxies AS g
LEFT JOIN dbo.nms_star_systems AS s
    ON g.galaxy_id = s.galaxy_id
LEFT JOIN dbo.nms_planets AS p
    ON s.system_id = p.system_id
GROUP BY g.galaxy_name
ORDER BY COUNT(p.planet_name) DESC;

-- 10. List every planet that has at least one rare fauna species recorded. 
-- Show planet name, biome, and the fauna species name. 

SELECT p.planet_name,
    p.biome,
    f.species_name
FROM dbo.nms_planets AS p
JOIN dbo.nms_fauna AS f
    ON p.planet_id = f.planet_id
WHERE f.rarity = 'Rare';


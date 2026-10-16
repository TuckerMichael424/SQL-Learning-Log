
-- 1.List every planet name, its biome, and the star system it belongs to. 

SELECT p.planet_name,
    p.biome,
    s.system_name
FROM dbo.nms_planets AS p
LEFT JOIN dbo.nms_star_systems AS s
    ON p.system_id = s.system_id;

-- 2. For each sentinel level, count how many planets have that level. Sort by count descending. 

SELECT COUNT(planet_id) AS planet_count,
    sentinel_level
FROM dbo.nms_planets
GROUP BY sentinel_level;

-- 3. Show every star system name and its economy type. Include systems even if the economy type is NULL. 

SELECT system_name,
    economy_type
FROM dbo.nms_star_systems
WHERE economy_type IS NOT NULL OR economy_type IS NULL;

-- 4.For each galaxy, count how many star systems have a Strong economy strength. Show galaxy name and count. 

SELECT g.galaxy_name,
    COUNT(s.system_id) AS system_count
FROM dbo.nms_galaxies AS g
LEFT JOIN dbo.nms_star_systems AS s
    ON g.galaxy_id = s.galaxy_id
WHERE s.economy_strength = 'Strong'
GROUP BY g.galaxy_name;

-- 5.  List every planet and any minerals found on it. Show planet name, biome, and mineral name. Include planets with no minerals recorded.ABORT

SELECT p.planet_name,
    p.biome,
    m.mineral_name
FROM dbo.nms_planets AS p
LEFT JOIN dbo.nms_minerals AS m
    ON p.planet_id = m.planet_id;

-- 6. List planet name, weather type, and biome. 

SELECT planet_name,
    weather,
    biome
FROM dbo.nms_planets

-- 7. For each weather type, count how many planets have it. Show weather type and planet count, highest first. 

SELECT weather,
    COUNT(planet_id) AS planet_count
FROM dbo.nms_planets
GROUP BY weather
ORDER BY COUNT(planet_id)

-- 8. Show every planet name and its atmosphere color, plus the name of the star system it belongs to. Include planets even if their system somehow has no name. 

SELECT P.planet_name,
    p.atmosphere_color,
    s.system_name
FROM dbo.nms_planets AS p
LEFT JOIN dbo.nms_star_systems AS s
    ON p.system_id = s.system_id

-- 9. For each starr faction (Gek, Vykeen, Korvax), count how many systems have a Strong Economy. Show faction name and count. Include factions even if they have zero strong economy systems. 

SELECT faction,
    COUNT(CASE WHEN economy_strength = 'Strong' THEN 1 END) AS strong_econ_systems
FROM dbo.nms_star_systems
GROUP BY faction

-- 10. For each planet, show the name, biome, and total number of fauna species recorded on it (inclusive - show 0, not NULL). 

SELECT p.planet_name,
    p.biome,
    COUNT(f.species_name) AS fauna_count
FROM dbo.nms_planets AS p
LEFT JOIN dbo.nms_fauna AS f
    ON p.planet_id = f.planet_id
GROUP BY p.planet_name, p.biome

-- 11. For each star color, count how many systems have an Outlaw faction flag set to TRUE. Show star color and outlaw count. Include all star colors even if none of their systems are outlaw. 

SELECT s.star_color,
    COUNT(CASE WHEN is_outlaw = 1 THEN 1 END) AS outlaw_count
FROM dbo.nms_star_systems AS s
GROUP BY s.star_color;

-- 12. For each planet, show thep lanet name and the total metal content percentage across all its minerals. If a planet has no minerals recorded, show 0.00 instead of NULL. 

SELECT p.planet_name,
    COALESCE(SUM(m.metal_content_pct), 0) AS total_mineral_pct
FROM dbo.nms_planets AS p
LEFT JOIN dbo.nms_minerals AS m
    ON p.planet_id = m.planet_id
GROUP BY p.planet_name;

-- 13. For each biome, show - the biome name, count of planets that have water, total fauna species recorded across all planets in that biome. If a biome has no fauna, show 0. 

SELECT p.biome,
    COUNT(CASE WHEN has_water = 1 THEN 1 END) AS has_water,
    COALESCE(SUM(fauna_id), 0) AS total_fauna
FROM dbo.nms_planets AS p
LEFT JOIN dbo.nms_fauna AS f
    ON p.planet_id = f.planet_id
GROUP BY p.biome;
-- ============================================================
-- NMS PRACTICE ROUND 2 — REVIEWED & CORRECTED
-- Reviewed by: Quinn (SQL Mentor)
-- ============================================================

-- 1. Count how many star systems exist per galaxy. Show galaxy name and system count.

SELECT g.galaxy_name,
    COUNT(s.system_id) AS system_count
FROM dbo.nms_galaxies AS g
LEFT JOIN dbo.nms_star_systems AS s
    ON g.galaxy_id = s.galaxy_id
GROUP BY g.galaxy_name
ORDER BY system_count DESC;

-- Claude Input: ✅ Perfect. Correct JOIN direction, GROUP BY, and aggregate. Nothing to fix.


-- ============================================================

-- 2. For each star system, show the system name and total number of fauna species
-- recorded across all planets in that system. Sort in descending.

-- Claude Input: ⚠️ JOIN chain issue — mixing LEFT JOIN (systems → planets) with INNER JOIN
-- (planets → fauna) drops any system that has planets with no fauna. The INNER JOIN
-- cancels out what the LEFT JOIN was trying to protect. Keep the whole chain LEFT JOIN
-- if you want to preserve all systems regardless of fauna coverage.

SELECT s.system_name,
    COUNT(f.species_name) AS fauna_count
FROM dbo.nms_star_systems AS s
LEFT JOIN dbo.nms_planets AS p
    ON s.system_id = p.system_id
LEFT JOIN dbo.nms_fauna AS f
    ON p.planet_id = f.planet_id
GROUP BY s.system_name
ORDER BY fauna_count DESC;


-- ============================================================

-- 3. List every star system and its galaxy name.
-- Include star systems even if their galaxy has no type recorded.

-- Claude Input: ⚠️ GROUP BY without aggregation — no COUNT, SUM, or other aggregate
-- function is present, so GROUP BY is just doing DISTINCT's job awkwardly. When you
-- are only listing columns with no math, drop GROUP BY entirely. The JOIN already
-- produces one row per system naturally.

SELECT s.system_name,
    g.galaxy_name,
    g.galaxy_subtype
FROM dbo.nms_star_systems AS s
LEFT JOIN dbo.nms_galaxies AS g
    ON s.galaxy_id = g.galaxy_id;


-- ============================================================

-- 4. Find all biomes that have more than 3 planets recorded.
-- Show the biome name, and planet count.

SELECT biome,
    COUNT(planet_id) AS planet_count
FROM dbo.nms_planets
GROUP BY biome
HAVING COUNT(planet_id) >= 3;

-- Claude Input: ✅ Correct. HAVING used properly after GROUP BY. Aggregate and threshold correct.


-- ============================================================

-- 5. For each galaxy and star color combination, count how many star systems exist.
-- Show galaxy name, star color, and system count.

SELECT g.galaxy_name,
    s.star_color,
    COUNT(system_id) AS system_count
FROM dbo.nms_star_systems AS s
LEFT JOIN dbo.nms_galaxies AS g
    ON s.galaxy_id = g.galaxy_id
GROUP BY g.galaxy_name, s.star_color;

-- Claude Input: ✅ Correct. Two GROUP BY columns for two "per" dimensions. Clean.


-- ============================================================

-- 6. List every planet and its sentinel level, plus the name of any fauna found on it.
-- Show planets even if no fauna has been recorded there yet.

-- Claude Input: ⚠️ GROUP BY without aggregation — same issue as Query 3. No aggregate
-- function is present, so GROUP BY is unnecessary. The LEFT JOIN already handles
-- producing one row per planet-fauna combination. Drop GROUP BY entirely.

SELECT p.planet_name,
    p.sentinel_level,
    f.species_name
FROM dbo.nms_planets AS p
LEFT JOIN dbo.nms_fauna AS f
    ON p.planet_id = f.planet_id;


-- ============================================================

-- 7. For each planet, show the planet name, biome, and count of distinct resource types available.

SELECT p.planet_name,
    p.biome,
    COUNT(DISTINCT r.resource_group) AS numb_resource_groups
FROM dbo.nms_planets AS p
LEFT JOIN dbo.nms_planet_resources AS r
    ON p.planet_id = r.planet_id
GROUP BY p.planet_name, p.biome;

-- Claude Input: ✅ Correct GROUP BY and aggregate. Minor improvement: COUNT(DISTINCT r.resource_group)
-- is more precise than COUNT(r.resource_group) — it counts unique resource group types
-- rather than total resource rows, which is what the question is asking for.


-- ============================================================

-- 8. Find all planets that have NO minerals recorded in the minerals table.
-- Show planet name & biome.

-- Claude Input: ❌ Wrong table — the question asked for the nms_minerals table, not
-- nms_planet_resources. These are two different tables. The anti-join logic was correct
-- (LEFT JOIN + IS NULL on the right table's key column) but pointed at the wrong place.
-- Also no GROUP BY needed here since there is no aggregation.

SELECT p.planet_name,
    p.biome
FROM dbo.nms_planets AS p
LEFT JOIN dbo.nms_minerals AS m
    ON p.planet_id = m.planet_id
WHERE m.mineral_id IS NULL;


-- ============================================================

-- 9. Find all star systems in Yellow star systems that have at least 2 planets.
-- Show system name, star color, and planet count.

SELECT s.system_name,
    s.star_color,
    COUNT(planet_id) AS planet_count
FROM dbo.nms_star_systems AS s
LEFT JOIN dbo.nms_planets AS p
    ON s.system_id = p.system_id
WHERE s.star_color = 'Yellow'
GROUP BY s.system_name, s.star_color
HAVING COUNT(p.planet_id) >= 2;

-- Claude Input: ✅ Correct. WHERE used for raw column filter before grouping, HAVING used
-- for aggregate filter after grouping. Applied in the right order. Solid.


-- ============================================================

-- 10. For each galaxy type, show: galaxy type, total number of star systems,
-- total number of planets. Sort by total planets descending.

SELECT g.galaxy_type,
    COUNT(s.system_id) AS total_systems,
    COUNT(p.planet_id) AS total_planets
FROM dbo.nms_galaxies AS g
LEFT JOIN dbo.nms_star_systems AS s
    ON g.galaxy_id = s.galaxy_id
LEFT JOIN dbo.nms_planets AS p
    ON s.system_id = p.system_id
GROUP BY g.galaxy_type
ORDER BY total_planets DESC;

-- Claude Input: ✅ Three table LEFT JOIN chain, two aggregates, single GROUP BY column.
-- Clean and correct. ORDER BY on alias works correctly in T-SQL.
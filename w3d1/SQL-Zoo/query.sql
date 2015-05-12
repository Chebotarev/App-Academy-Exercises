-- SELECT
--   ab.num,
--   ab.company,
--   ab.stop_name,
--   c.num,
--   c.company
-- FROM
-- (
--   SELECT DISTINCT
--     a.num,
--     a.company,
--     stopb.name AS stop_name
--   FROM
--    routes a
--   JOIN
--     routes b ON (a.company = b.company AND a.num = b.num)
--   JOIN
--     stops stopa ON (a.stop_id = stopa.id)
--   JOIN
--     stops stopb ON (b.stop_id = stopb.id)
--
--   WHERE
--     stopa.name = 'Craiglockhart'
-- ) ab
--   JOIN
--     routes c ON (c.company = ab.company AND c.num = ab.num)
--   JOIN
--     stops stopc ON (c.stop_id = stopc.id)
--   WHERE
--     stopc.name = 'Sighthill';

SELECT DISTINCT
  a.num,
  a.company,
  stopb.name,
  d.num,
  d.company
FROM
 routes a
JOIN
  routes b ON (a.company = b.company AND a.num = b.num)
JOIN
  routes c ON (c.stop_id = b.stop_id)
JOIN
  routes d ON (d.company = c.company AND d.num = c.num)
JOIN
  stops stopa ON (a.stop_id = stopa.id)
JOIN
  stops stopb ON (b.stop_id = stopb.id)
JOIN
  stops stopc ON (c.stop_id = stopc.id)
JOIN
  stops stopd ON (d.stop_id = stopd.id)
WHERE
  stopa.name = 'Craiglockhart' AND stopd.name = 'Sighthill';

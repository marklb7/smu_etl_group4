--Query 1
select
	first_name,
	last_name,
	position,
	team_id,
	games_played,
	goals,
	assists,
	points
	penalty_minutes
from
	player
join player_stats as ps
	on player.id = ps.player_id

--Query 2
select
	p.first_name,
	p.last_name,
	p.position,
	t.team_abbr
from
	player as p
join teams as t
	on p.team_id = t.id
where
	t.team_abbr = 'DAL'

--Query 3
select
	d.division_name,
	c.conference_name
from
	lk_division as d
join lk_conference as c
	on d.conference_id = c.id
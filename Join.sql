1.Show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'.

SELECT matchid, player
FROM goal 
WHERE teamid = 'GER';

2.Show id, stadium, team1, team2 for just game 1012

SELECT id,stadium,team1,team2
FROM game
WHERE id =1012;

3.Show the player, teamid, stadium and mdate for every German goal.

SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (id=matchid)
WHERE teamid = 'GER';

4.Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

SELECT team1, team2, player
FROM game JOIN goal on id = matchid
WHERE player LIKE 'Mario%';

5.Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT player, teamid, coach, gtime
FROM goal JOIN eteam on id = teamid
WHERE gtime<=10;

6.List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT mdate, teamname
FROM game JOIN eteam ON team1 = eteam.id
WHERE coach = 'Fernando Santos';

7.List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT player
FROM game JOIN goal ON matchid = id 
WHERE stadium = 'National Stadium, Warsaw';

8a.Shows all goals scored in the Germany-Greece quarterfinal.

SELECT player, gtime
FROM game JOIN goal ON matchid = id 
WHERE (team1='GER' AND team2='GRE')

8b.Show the name of all players who scored a goal against Germany.

SELECT DISTINCT player
FROM game JOIN goal ON matchid = id 
WHERE (team1='GER' OR team2='GER')
AND teamid <>'GER';

9.Show teamname and the total number of goals scored.

SELECT teamname, COUNT(*)
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname;

10.Show the stadium and the number of goals scored in each stadium.

SELECT stadium, COUNT(*)
FROM game JOIN goal ON id = matchid
GROUP BY  stadium;
 
11.For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT matchid,mdate, COUNT(*)
FROM game JOIN goal ON matchid = id 
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid,mdate;

12.For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT matchid, mdate, COUNT(*)
FROM goal JOIN game ON  id  = matchid
WHERE teamid = 'GER' 
GROUP BY matchid, mdate;

13.
/*List every match with the goals scored by each team as shown. 
This will use "CASE WHEN" which has not been explained in any previous exercises.
Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. 
You could SUM this column to get a count of the goals scored by team1. 
Sort your result by mdate, matchid, team1 and team2.
*/

SELECT mdate,team1,
SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) as score1, 
team2, SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) as score2
FROM game LEFT JOIN goal ON matchid = id
GROUP BY mdate, team1, team2
ORDER BY mdate, team1, team2;

14.Quiz
#Shows the player, their team and the time they scored, for players who have played in Stadion Miejski (Wroclaw) 
but not against Italy(ITA).

SELECT DISTINCT player, teamid, gtime
  FROM game JOIN goal ON matchid = id
 WHERE stadium = 'Stadion Miejski (Wroclaw)'
   AND (( teamid = team2 AND team1 != 'ITA') OR ( teamid = team1 AND team2 != 'ITA'))
   
   
**
https://www.sqlskills.com/blogs/conor/countstar-vs-countcolumn-vs-countdistinct-vs-countcol-over/

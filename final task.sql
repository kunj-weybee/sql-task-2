-- 1 .
 select mov_title, mov_year from  movie

-- 2 .
 select mov_year from  movie
 where mov_title = 'American Beauty'

-- 3 .
 select mov_title from  movie
 where mov_year = 1999

-- 4 . 
 select mov_title from  movie
 where mov_year < 1998

-- 5 .
 select m.mov_title , r2.rev_name from (( rating r1

 inner join movie m
 on r1.mov_id = m.mov_id)

 inner join reviewer r2
 on r1.rev_id = r2.rev_id)

-- 6 .
 select r2.rev_name , r1.rev_stars from rating r1
 inner join reviewer r2
 on r1.rev_id = r2.rev_id
 where r1.rev_stars >=7

 -- 7 .
 select m.mov_title , r.rev_stars from rating r
 inner join movie m
 on r.mov_id = m.mov_id
 where r.rev_stars is null

 -- 8 .
  select mov_id , mov_title from movie
  where mov_id in (905 , 907 , 917)

  -- 9 . 
  select mov_id , mov_title , mov_year from movie
  where mov_title like '%Boogie Nights%'
  order by mov_year asc

 -- 10 .
 select act_id from actor
 where act_fname= 'Woody' and act_lname= 'Allen'






# SUB QUERY  ######################################################################################################################################################



 -- 1 .

 select a.act_fname , m.role from movie_cast m
 inner join actor a
 on m.act_id = a.act_id
 where mov_id = ( select mov_id 
				  from movie
				  where mov_title = 'Annie Hall' )

 -- 2 .

 select d.dir_fname , d.dir_lname from director d
 inner join movie_direction md
 on d.dir_id = md.dir_id
 where md.mov_id = (select mov_id
					from movie
					where mov_title = 'Eyes Wide Shut')



-- 3 .

select mov_title,mov_rel_country from movie
where mov_rel_country <> (select distinct mov_rel_country
						  from movie
						  where mov_rel_country = 'UK')




-- 4. 
select m.mov_title from movie m
inner join movie_direction md
on m.mov_id = md.mov_id
where md.dir_id = ( select dir_id
					from director 
					where dir_fname = 'Woody')

-- movie			(mov_id)(pk)
-- movie_direction	(mov_id (fk) , dir_id (fk))     movie and movie_direction is inner join and using sub qury on director.
-- director			(dir_id)(pk)

					

-- 5 . (need to took help)
select m.mov_title , m.mov_year , m.mov_dt_rel , j.rev_name , d.dir_fname , d.dir_lname , a.act_fname , a.act_lname from movie m

inner join rating r
on m.mov_id = r.mov_id 

inner join 
(select rev_id , rev_name	
 from reviewer
 where rev_name = '') j
 on r.rev_id = j.rev_id 

 inner join movie_direction md
 on m.mov_id = md.mov_id
 
 inner join director d
 on md.dir_id = d.dir_id

 inner join movie_cast mc
 on m.mov_id = mc.mov_id

 inner join actor a
 on mc.act_id = a.act_id


  -- 6 .

  select * from 
		(
			select count(*) as total, m.mov_year from movie m
			inner join rating r
			on m.mov_id = r.mov_id
			group by m.mov_year
		) as sub_query
  where total >= 1


  -- 7 .

  select mov_title from movie
  where mov_id IN (	select mov_id
					from rating
					where num_o_ratings is null)




-- 8 . 

select rev_id , rev_name from reviewer
where rev_id not in (select rev_id
				from rating)



-- 9 .
	-- 1 way
	select * from reviewer r
	where r.rev_id in ( select rev_id
						from rating 
						where num_o_ratings IS NOT NULL)
	order by rev_name


	-- 2 way
	select * from reviewer
	where rev_id in (   select rev_id from movie m
						inner join rating R
						on m.mov_id = R.mov_id
						where num_o_ratings IS NOT NULL)
	order by rev_name


-- 11 .

select distinct top 1 * from ( 
	select r.rev_stars, m.mov_title ,rr.rev_name from rating r
	inner join reviewer rr
	on r.rev_id = rr.rev_id
	
	inner join movie m
	on r.mov_id = m.mov_id
) as sub_query
order by rev_stars desc
		



	-- 12 .

	select r.rev_name from reviewer r							-- g maigu hoi e table
	inner join rating rr 
	on r.rev_id = rr.rev_id
	where rr.mov_id = (select mov_id
					from movie
					where mov_title='American Beauty')			-- g didhu hoi e table



	
	-- 13 .
	
	select m.mov_title from movie m
	inner join rating r
	on r.mov_id = m.mov_id
	where r.rev_id != (	select rev_id
					from reviewer
					where rev_name='Paul Monks'
			   )

	-- both are same just used { != } and { not in }

	select m.mov_title from movie m
	inner join rating r
	on r.mov_id = m.mov_id
	where r.rev_id not in (	select rev_id
					from reviewer
					where rev_name='Paul Monks'
			   )




-- 14 .  

SELECT sub.mov_title,sub.rev_stars,r.rev_name FROM (
	select r.rev_id , r.mov_id , m.mov_title , r.rev_stars from rating r
	inner join movie m
	on r.mov_id = m.mov_id
	WHERE rev_stars = ( 
						SELECT MIN(rev_stars) 
						FROM rating 					
					   )
) AS sub
INNER JOIN reviewer r
on sub.rev_id = r.rev_id




-- 15 . 

SELECT m.mov_title FROM movie m
inner join rating r 
on m.mov_id = r.mov_id
where r.rev_id = (  select rev_id
					from reviewer
					where rev_name = 'James Cameron')




-- 16 . 


 select n.mov_id , a.mov_title from movie_cast m , movie_cast n
 inner join movie a
 on a.mov_id = n.mov_id
 where m.act_id = n.act_id and m.mov_id != n.mov_id
					  



# JOIN ############################################################################################################################################################

 -- 1.

 select r.rev_name from reviewer r
 inner join rating rr
 on r.rev_id = rr.rev_id
 where rr.rev_stars is null



 --2 .

 select a.act_fname,a.act_lname,mc.role from movie_cast mc
 inner join actor a
 on mc.act_id = a.act_id
 inner join movie m
 on mc.mov_id = m.mov_id
 where m.mov_title='Annie Hall'



 -- 3 .
 
 select n.mov_title, d.dir_fname, d.dir_lname from movie n
 inner join movie_direction m
 on n.mov_id = m.mov_id
 inner join director d
 on m.dir_id = d.dir_id
 where n.mov_title='Eyes Wide Shut'	


 -- 4 .

 select d.dir_fname,d.dir_lname,m.mov_title from movie m
 inner join movie_cast c
 on m.mov_id = c.mov_id
 inner join movie_direction md
 on m.mov_id = md.mov_id
 inner join director d
 on md.dir_id = d.dir_id
 where c.role='Sean Maguire'



 -- 5.


 select a.act_fname,a.act_lname,m.mov_title,m.mov_year from movie_cast c
 inner join movie m
 on c.mov_id = m.mov_id
 inner join actor a
 on c.act_id = a.act_id
 where m.mov_year not between 1990 AND 2000


 -- 6 .

 select count(*) as total_genre , d.dir_fname from genres g
 inner join movie_genres mm
 on g.gen_id = mm.gen_id
 inner join movie m
 on mm.mov_id = m.mov_id
 inner join movie_direction dd
 on m.mov_id = dd.mov_id
 inner join director d
 on dd.dir_id = d.dir_id
 group by d.dir_fname



 -- 7 .

 select m.mov_title, m.mov_year, g.gen_title from genres g
 inner join movie_genres mm
 on g.gen_id = mm.gen_id
 inner join movie m
 on mm.mov_id = m.mov_id


 --  8 .

 select m.mov_year, g.gen_title, d.dir_fname from genres g
 inner join movie_genres mm
 on g.gen_id = mm.gen_id
 inner join movie m
 on mm.mov_id = m.mov_id
 inner join movie_direction dd
 on m.mov_id = dd.mov_id
 inner join director d	
 on dd.dir_id = d.dir_id


 -- 9 . 

 select m.mov_title, m.mov_year, m.mov_dt_rel, m.mov_time, d.dir_fname, d.dir_lname from movie m
 inner join movie_direction md
 on m.mov_id = md.mov_id
 inner join director d
 on md.dir_id = d.dir_id
 where mov_dt_rel < '01-01-1989'
 order by mov_dt_rel desc


 -- 10.

 select g.gen_title ,avg(m.mov_time) as timeavg, count(m.mov_title) from genres g
 inner join movie_genres mm
 on g.gen_id = mm.gen_id
 inner join movie m
 on mm.mov_id = m.mov_id
 inner join movie_direction dd
 on m.mov_id = dd.mov_id
 inner join director d	
 on dd.dir_id = d.dir_id
 group by g.gen_title


 -- 11 .,

  select m.mov_title, m.mov_year, d.dir_fname, d.dir_lname , a.act_fname, a.act_lname from movie m
 inner join movie_direction md
 on m.mov_id = md.mov_id
 inner join director d
 on md.dir_id = d.dir_id
 inner join movie_cast cm
 on m.mov_id = cm.mov_id
 inner join actor a
 on cm.act_id = a.act_id


 -- 12 .

 select * from movie m
 inner join rating r
 on m.mov_id=r.mov_id
 where r.rev_stars between 3 and 4


 -- 13 .

 select r.rev_name,m.mov_title , rr.rev_stars from reviewer r
 inner join rating rr
 on r.rev_id = rr.rev_id
 inner join movie m
 on rr.mov_id = m.mov_id


 -- 14 .

 select count(r.rev_stars) as star, m.mov_title, max(r.num_o_ratings) as num_of_rating from movie m
 inner join rating r
 on m.mov_id=r.mov_id
 group by m.mov_title
 having count(r.rev_stars) >= 1
 order by m.mov_title asc


 -- 15.


 select m.mov_title, d.dir_fname, d.dir_lname, r.rev_stars from movie m
 inner join rating r
 on m.mov_id=r.mov_id
 inner join movie_direction dm
 on m.mov_id = dm.mov_id
 inner join director d
 on dm.dir_id = d.dir_id
 where r.num_o_ratings is not null
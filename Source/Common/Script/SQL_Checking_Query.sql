select ClubId, u.UserId, ClubName, u.FullName from Club c join [User] u on u.UserId=c.UserId;
select LeagueId, u.UserId, FullName, LeagueName, LeagueType, NoParticipate from League l join [User] u on u.UserId=l.UserId;

select u.UserId, u.FullName, c.ClubName, u.Email from [User] u join Club c on u.userId = c.userId
where u.Role = 'Club_MANAGER'
order by ClubName;
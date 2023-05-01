  update SquadPosition set CoordinateX = 279, CoordinateY = 595 where PositionKey = 'P1' and SquadId in (SELECT SquadId FROM Squad where NoPlayerSquad = 7);
  update SquadPosition set CoordinateX = 279, CoordinateY = 461 where PositionKey = 'P2' and SquadId in (SELECT SquadId FROM Squad where NoPlayerSquad = 7);
  update SquadPosition set CoordinateX = 487, CoordinateY = 373 where PositionKey = 'P3' and SquadId in (SELECT SquadId FROM Squad where NoPlayerSquad = 7);
  update SquadPosition set CoordinateX = 72, CoordinateY = 370 where PositionKey = 'P4' and SquadId in (SELECT SquadId FROM Squad where NoPlayerSquad = 7);
  update SquadPosition set CoordinateX = 395, CoordinateY = 205 where PositionKey = 'P5' and SquadId in (SELECT SquadId FROM Squad where NoPlayerSquad = 7);
  update SquadPosition set CoordinateX = 156, CoordinateY = 205 where PositionKey = 'P6' and SquadId in (SELECT SquadId FROM Squad where NoPlayerSquad = 7);
  update SquadPosition set CoordinateX = 277, CoordinateY = 61 where PositionKey = 'P7' and SquadId in (SELECT SquadId FROM Squad where NoPlayerSquad = 7);
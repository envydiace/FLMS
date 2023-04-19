﻿namespace FLMS_BackEnd.DTO
{
    public class LeagueDTO
    {
        public int LeagueId { get; set; }
        public int UserId { get; set; }
        public string LeagueName { get; set; } = null!;
        public int NoParticipate { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int MaxNoPlayer { get; set; }
        public int NoPlayerSquad { get; set; }
        public string? Location { get; set; }
        public string? Fanpage { get; set; }
        public DateTime CreateAt { get; set; }
        public string? Description { get; set; }
        public string LeagueType { get; set; } = null!;
        public int? NoRound { get; set; }
        public string? Logo { get; set; }
        public string Status { get; set; } = null!;
    }
}

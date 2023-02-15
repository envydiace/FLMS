using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace FLMS_BackEnd.Models
{
    public partial class FLMS_DBContext : DbContext
    {
        public FLMS_DBContext()
        {
        }

        public FLMS_DBContext(DbContextOptions<FLMS_DBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Club> Clubs { get; set; } = null!;
        public virtual DbSet<ClubLeague> ClubLeagues { get; set; } = null!;
        public virtual DbSet<League> Leagues { get; set; } = null!;
        public virtual DbSet<LeagueFee> LeagueFees { get; set; } = null!;
        public virtual DbSet<Match> Matches { get; set; } = null!;
        public virtual DbSet<MatchEvent> MatchEvents { get; set; } = null!;
        public virtual DbSet<MatchStat> MatchStats { get; set; } = null!;
        public virtual DbSet<Participation> Participations { get; set; } = null!;
        public virtual DbSet<Player> Players { get; set; } = null!;
        public virtual DbSet<PlayerClub> PlayerClubs { get; set; } = null!;
        public virtual DbSet<RefreshToken> RefreshTokens { get; set; } = null!;
        public virtual DbSet<Request> Requests { get; set; } = null!;
        public virtual DbSet<User> Users { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("server =LAPTOP-0UTUQB0L\\MSSQLSERVER07; database =FLMS_DB;uid=sa;pwd=1234567890;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Club>(entity =>
            {
                entity.ToTable("Club");

                entity.Property(e => e.ClubName).HasMaxLength(100);

                entity.Property(e => e.CreateAt).HasColumnType("smalldatetime");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Clubs)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Club__UserId__0A688BB1");
            });

            modelBuilder.Entity<ClubLeague>(entity =>
            {
                entity.ToTable("ClubLeague");

                entity.Property(e => e.ClubName).HasMaxLength(1);

                entity.HasOne(d => d.Club)
                    .WithMany(p => p.ClubLeagues)
                    .HasForeignKey(d => d.ClubId)
                    .HasConstraintName("FK__ClubLeagu__ClubI__0B5CAFEA");
            });

            modelBuilder.Entity<League>(entity =>
            {
                entity.ToTable("League");

                entity.Property(e => e.EndDate).HasColumnType("datetime");

                entity.Property(e => e.Fanpage).HasMaxLength(255);

                entity.Property(e => e.LeagueName).HasMaxLength(100);

                entity.Property(e => e.Location).HasMaxLength(255);

                entity.Property(e => e.StartDate).HasColumnType("datetime");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Leagues)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__League__UserId__0880433F");
            });

            modelBuilder.Entity<LeagueFee>(entity =>
            {
                entity.ToTable("LeagueFee");

                entity.Property(e => e.ExpenseKey).HasMaxLength(10);

                entity.Property(e => e.ExpenseName).HasMaxLength(50);

                entity.HasOne(d => d.League)
                    .WithMany(p => p.LeagueFees)
                    .HasForeignKey(d => d.LeagueId)
                    .HasConstraintName("FK__LeagueFee__Leagu__09746778");
            });

            modelBuilder.Entity<Match>(entity =>
            {
                entity.ToTable("Match");

                entity.HasOne(d => d.Away)
                    .WithMany(p => p.MatchAways)
                    .HasForeignKey(d => d.AwayId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Match__AwayId__1209AD79");

                entity.HasOne(d => d.Home)
                    .WithMany(p => p.MatchHomes)
                    .HasForeignKey(d => d.HomeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Match__HomeId__11158940");

                entity.HasOne(d => d.League)
                    .WithMany(p => p.Matches)
                    .HasForeignKey(d => d.LeagueId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Match__LeagueId__10216507");
            });

            modelBuilder.Entity<MatchEvent>(entity =>
            {
                entity.ToTable("MatchEvent");

                entity.Property(e => e.EventType).HasMaxLength(255);

                entity.HasOne(d => d.Main)
                    .WithMany(p => p.MatchEventMains)
                    .HasForeignKey(d => d.MainId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__MatchEven__MainI__55BFB948");

                entity.HasOne(d => d.Match)
                    .WithMany(p => p.MatchEvents)
                    .HasForeignKey(d => d.MatchId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__MatchEven__Match__57A801BA");

                entity.HasOne(d => d.Support)
                    .WithMany(p => p.MatchEventSupports)
                    .HasForeignKey(d => d.SupportId)
                    .HasConstraintName("FK__MatchEven__Suppo__56B3DD81");
            });

            modelBuilder.Entity<MatchStat>(entity =>
            {
                entity.ToTable("MatchStat");

                entity.HasOne(d => d.Match)
                    .WithMany(p => p.MatchStats)
                    .HasForeignKey(d => d.MatchId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__MatchStat__Match__00DF2177");
            });

            modelBuilder.Entity<Participation>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("Participation");

                entity.HasOne(d => d.Club)
                    .WithMany()
                    .HasForeignKey(d => d.ClubId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Participa__ClubI__0D44F85C");

                entity.HasOne(d => d.League)
                    .WithMany()
                    .HasForeignKey(d => d.LeagueId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Participa__Leagu__0C50D423");
            });

            modelBuilder.Entity<Player>(entity =>
            {
                entity.ToTable("Player");

                entity.Property(e => e.Address).HasMaxLength(255);

                entity.Property(e => e.Dob).HasColumnType("datetime");

                entity.Property(e => e.Email).HasMaxLength(255);

                entity.Property(e => e.Height).HasMaxLength(10);

                entity.Property(e => e.Name).HasMaxLength(200);

                entity.Property(e => e.NickName).HasMaxLength(20);

                entity.Property(e => e.PhoneNumber).HasMaxLength(15);

                entity.Property(e => e.SocialCont).HasMaxLength(255);

                entity.Property(e => e.Weight).HasMaxLength(10);
            });

            modelBuilder.Entity<PlayerClub>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("PlayerClub");

                entity.HasOne(d => d.Club)
                    .WithMany()
                    .HasForeignKey(d => d.ClubId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__PlayerClu__ClubI__0F2D40CE");

                entity.HasOne(d => d.Player)
                    .WithMany()
                    .HasForeignKey(d => d.PlayerId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__PlayerClu__Playe__0E391C95");
            });

            modelBuilder.Entity<RefreshToken>(entity =>
            {
                entity.HasKey(e => e.TokenId);

                entity.ToTable("RefreshToken");

                entity.Property(e => e.CreateAt).HasColumnType("smalldatetime");

                entity.Property(e => e.ExpiryDate).HasColumnType("smalldatetime");

                entity.Property(e => e.TokenHash).HasMaxLength(1000);

                entity.Property(e => e.TokenSalt).HasMaxLength(1000);

                entity.HasOne(d => d.User)
                    .WithMany(p => p.RefreshTokens)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__RefreshTo__UserI__078C1F06");
            });

            modelBuilder.Entity<Request>(entity =>
            {
                entity.ToTable("Request");

                entity.Property(e => e.RequestType).HasMaxLength(255);

                entity.HasOne(d => d.Club)
                    .WithMany(p => p.Requests)
                    .HasForeignKey(d => d.ClubId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Request__ClubId__3552E9B6");

                entity.HasOne(d => d.League)
                    .WithMany(p => p.Requests)
                    .HasForeignKey(d => d.LeagueId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Request__LeagueI__345EC57D");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.ToTable("User");

                entity.Property(e => e.Address).HasMaxLength(255);

                entity.Property(e => e.CreateAt).HasColumnType("smalldatetime");

                entity.Property(e => e.Email).HasMaxLength(150);

                entity.Property(e => e.FullName).HasMaxLength(255);

                entity.Property(e => e.Password).HasMaxLength(255);

                entity.Property(e => e.PasswordSalt).HasMaxLength(255);

                entity.Property(e => e.Phone).HasMaxLength(255);

                entity.Property(e => e.Role).HasMaxLength(20);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}

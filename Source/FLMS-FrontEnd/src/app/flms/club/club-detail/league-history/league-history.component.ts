import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { ActivatedRoute, Router } from '@angular/router';
import { map } from 'rxjs/operators';
import { ClubLeagueHistory } from 'src/app/models/club-league-history.model';
import { ClubService } from '../../club.service';

@Component({
  selector: 'app-league-history',
  templateUrl: './league-history.component.html',
  styleUrls: ['./league-history.component.scss']
})
export class LeagueHistoryComponent implements OnInit {
  displayedColumns: string[] = ['joinedDate','leagueName', 'won','draw', 'loss', 'goal','rank'];
  clubId: number;
  leagueHistoryList: ClubLeagueHistory[];
  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private ClubService: ClubService,
    public dialog: MatDialog,

  ) { 
    this.route.queryParams.subscribe(params => {
      this.clubId = params['clubId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.ClubService.getClubLeagueHistory(this.clubId).pipe(
      map((res: ClubLeagueHistory[]) => this.leagueHistoryList = res
      )
    ).subscribe();
  }
}

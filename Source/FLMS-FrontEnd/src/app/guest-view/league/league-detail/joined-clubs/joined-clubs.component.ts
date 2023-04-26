import { Component, Input, OnInit } from '@angular/core';
import { ClubService } from 'src/app/guest-view/club/club.service';
import { map, tap } from 'rxjs/operators';
import { ClubDetailResponse } from 'src/app/models/club-detail-response.model';
import { LeagueService } from '../../league.service';
import { ClubListByLeagueResponse } from 'src/app/models/club-list-by-league-response.model';
import { ClubListByLeague } from 'src/app/models/club-list-by-league.model';
import { ActivatedRoute, Router } from '@angular/router';




@Component({
  selector: 'app-joined-clubs',
  templateUrl: './joined-clubs.component.html',
  styleUrls: ['./joined-clubs.component.scss']
})
export class JoinedClubsComponent implements OnInit {
  leagueId: string;
  @Input() clubName: string;
  listClubByLeague: ClubListByLeague[] = [];
  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';
  
  constructor(
    private route: ActivatedRoute,
    private leagueService: LeagueService,
    private router: Router,

  ) {
    this.route.queryParams.subscribe(params => {
      this.leagueId = params['leagueId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
  }

  navigateToClubInfo(clubId: number) {
    this.router.navigate(['/club-info'], { queryParams: {  clubId: clubId } });
  }

  initDataSource() {
    this.leagueService.findClubByLeague(this.leagueId, '').pipe(
      map((listClubByLeague: ClubListByLeagueResponse) => this.listClubByLeague = listClubByLeague.clubs)
    ).subscribe();
  }

  getClubbyName(clubName: string) {
    if (clubName == null) clubName = '';
    this.leagueService.findClubByLeague(this.leagueId, clubName).pipe(
      map((listClubByLeague: ClubListByLeagueResponse) => this.listClubByLeague = listClubByLeague.clubs)
    ).subscribe();
  }
}

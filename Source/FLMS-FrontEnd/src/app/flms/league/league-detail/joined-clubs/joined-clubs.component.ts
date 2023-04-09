import { Component, Input, OnInit } from '@angular/core';
// import { ClubService } from '/guest-view/club/club.service';
import { map, tap } from 'rxjs/operators';
import { ClubDetailResponse } from '../../../../models/club-detail-response.model';
import { LeagueService } from '../../league.service';
import { ClubListByLeagueResponse } from '../../../../models/club-list-by-league-response.model';
import { ClubListByLeague } from '../../../../models/club-list-by-league.model';
import { ActivatedRoute } from '@angular/router';
import { ConfirmFeeComponent } from '../confirm-fee/confirm-fee.component';
import { MatDialog } from '@angular/material/dialog';
import { MailDataResponse } from 'src/app/models/mail-data-response.model';
import { MailData } from 'src/app/models/mail-data.model';

import { CommonService } from './../../../../common/common/common.service';


@Component({
  selector: 'app-joined-clubs',
  templateUrl: './joined-clubs.component.html',
  styleUrls: ['./joined-clubs.component.scss']
})
export class JoinedClubsComponent implements OnInit {
  leagueId: string;
  clubId: number;
  // @Input() clubName: string;
  listClubByLeague: ClubListByLeague[] = [];
  mailData: MailData;
  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';



  constructor(
    private route: ActivatedRoute,
    private leagueService: LeagueService,
    public dialog: MatDialog,
    public commonService: CommonService
  ) {
    this.route.queryParams.subscribe(params => {
      this.leagueId = params['leagueId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
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
  openLeagueClubFee(clubId: number): void{
    const dialogRef = this.dialog.open(ConfirmFeeComponent, {
      width: '35%',
      data: { clubId: clubId, leagueId: this.leagueId}
    });

    dialogRef.afterClosed().subscribe(result => {
      this.initDataSource();
      console.log('The dialog was closed');
    });
  }

  RemoveJoinedClub(clubId: number) {
    let idTemp = +this.leagueId;
    this.leagueService.removeJoinedClub(idTemp, clubId).subscribe(res => {
      this.commonService.sendMessage(res.message, 'success');
      this.initDataSource();
    });
  }
}

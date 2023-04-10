
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatchDetail } from 'src/app/models/match-detail.model';
import { ChangeDetectorRef, Component, Inject, OnInit } from '@angular/core';
import { AddMatchEvent, MatchEvent } from 'src/app/models/match-event-detail.model';
import { PlayerForEvent } from 'src/app/models/player-for-event.model';
import { MatchService } from 'src/app/flms/match/match.service';
import { first, map } from 'rxjs/operators';
import { ClubListPlayerResponse } from 'src/app/models/club-list-player-response.model';
import { ClubListPlayer, getListPlayerJoinMatch } from 'src/app/models/club-list-player.model';
import { CommonService } from 'src/app/common/common/common.service';
import { PopUpRemoveEvemtComponent } from '../pop-up-remove-evemt/pop-up-remove-event.component'
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-pop-up-add-event',
  templateUrl: './pop-up-add-event.component.html',
  styleUrls: ['./pop-up-add-event.component.scss']
})
export class PopUpAddEventComponent implements OnInit {
  displayedColumns: string[] = ['time', 'type', 'team', 'player', 'assist', 'action']
  matchId: number;
  matchDetail: MatchDetail;
  addmatchEvent: AddMatchEvent[] = [];
  type: string = '';
  clubId: number;
  selectedPlayer: getListPlayerJoinMatch;
  selectedAssist: getListPlayerJoinMatch;
  listPlayer: getListPlayerJoinMatch[] = [];
  matchEvent: MatchEvent[] = [];
  time: number = 0;
  tempClubId: number;

  eventTime: number;
  eventType: string;

  matchDetailForm: FormGroup;

  constructor(
    private formBuilder: FormBuilder,
    public dialogRef: MatDialogRef<PopUpAddEventComponent>,
    public matchService: MatchService,
    public commonService: CommonService,
    public dialog: MatDialog,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      matchId: number;
      matchDetail: MatchDetail;
    }
  ) {
  }

  ngOnInit(): void {
    this.matchId = this.data.matchId;
    this.matchDetail = this.data.matchDetail;

    this.initDataSource();

  }

  initDataSource() {
    this.getMatchEvent(this.matchId);
  }

  getMatchEvent(matchId: number) {
    this.matchService.getMatchEvent(matchId).pipe(
      map((res: MatchEvent[]) => this.matchEvent = res)
    ).subscribe();
  }

  createForm(){
    this.matchDetailForm = this.formBuilder.group({
      
    });
  }

  onChangeTypeAndTeam($event: any) {
    // alert(this.type + this.clubId);
    if (this.type != null && this.type != undefined
      && this.clubId != null && this.clubId != undefined) {
      if (this.type == 'OwnGoal') {
        if (this.matchDetail.home.clubId == this.clubId) this.tempClubId = this.matchDetail.away.clubId;
        if (this.matchDetail.away.clubId == this.clubId) this.tempClubId = this.matchDetail.home.clubId;
      } else {
        this.tempClubId = this.clubId;
      }

      this.matchService.getListPlayerJoinMatch(this.tempClubId, this.data.matchId).pipe(map((res: getListPlayerJoinMatch[]) => {
        this.listPlayer = res
      })
      ).subscribe(res => {

      })
    }

  }

  addEventIntoList() {
    let eventTime: number = +this.time
    // if (eventTime >= 0 || eventTime <= 90) {
    //   eventTime = eventTime;
    // } else {

    // }
    const MatchEvent: AddMatchEvent = {
      matchId: this.matchId,
      eventTime: eventTime,
      eventType: this.type,
      clubId: this.clubId,
      mainId: this.selectedPlayer.playerId,
      subId: this.selectedAssist == null ? null : this.selectedAssist.playerId,
      mainName: this.selectedPlayer.name,
      subName: this.selectedAssist == null ? null : this.selectedAssist.name,
      clubName: this.matchDetail.home.clubId == this.clubId ? this.matchDetail.home.name : this.matchDetail.away.name
    }
    // this.addmatchEvent.push(MatchEvent);

    const newUsersArray = this.addmatchEvent;
    newUsersArray.push(MatchEvent);
    this.addmatchEvent = [...newUsersArray];
  }

  openConfirmedRemoveEvent(eventId: number): void {
    const dialogRef = this.dialog.open(PopUpRemoveEvemtComponent, {
      width: '30%',
      data: { eventId: eventId, }
    });

    dialogRef.afterClosed().subscribe(result => {
      this.initDataSource();
      console.log('The dialog was closed');
    });
  }
}






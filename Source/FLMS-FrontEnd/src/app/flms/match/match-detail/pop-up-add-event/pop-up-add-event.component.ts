
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
  displayedColumns: any[] = ['time', 'type', 'team', 'player', 'assist', 'action']
  matchId: number;
  matchDetail: MatchDetail;
  addmatchEvent: AddMatchEvent[] = [];

  listPlayer: getListPlayerJoinMatch[] = [];
  matchEvent: MatchEvent[] = [];

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

    this.createForm();
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

  createForm() {
    this.matchDetailForm = this.formBuilder.group({
      'eventTime': [null, [Validators.required, Validators.max(120), Validators.min(0)]],
      'eventType': [null, [Validators.required]],
      'clubId': [null, [Validators.required]],
      'main': [null, [Validators.required]],
      'sub': [null,]
    });
  }

  getControl(name: string) {
    return this.matchDetailForm.get(name) as FormControl;
  }

  onChangeTypeAndTeam($event: any) {
    // alert(this.type + this.clubId);
    if (this.getControl('eventType').value != null && this.getControl('eventType').value != undefined
      && this.getControl('clubId').value != null && this.getControl('clubId').value != undefined) {
      if (this.getControl('eventType').value == 'OwnGoal') {
        if (this.matchDetail.home.clubId == this.getControl('clubId').value) this.tempClubId = this.matchDetail.away.clubId;
        if (this.matchDetail.away.clubId == this.getControl('clubId').value) this.tempClubId = this.matchDetail.home.clubId;
      } else {
        this.tempClubId = this.getControl('clubId').value;
      }

      this.matchService.getListPlayerJoinMatch(this.tempClubId, this.data.matchId).pipe(map((res: getListPlayerJoinMatch[]) => {
        this.listPlayer = res
      })
      ).subscribe(res => {

      })
    }
  }



  addEventIntoList() {
    // stop here if form is invalid
    if (this.matchDetailForm.invalid) {
      return;
    }

    let eventTime: number = +this.getControl('eventTime').value;
    // if (eventTime >= 0 || eventTime <= 90) {
    //   eventTime = eventTime;

    const MatchEvent: AddMatchEvent = {
      matchId: this.matchId,
      eventTime: eventTime,
      eventType: this.getControl('eventType').value,
      clubId: this.getControl('clubId').value,
      mainId: this.getControl('main').value.playerId,
      subId: this.getControl('sub').value == null ? null : this.getControl('sub').value.playerId,
      mainName: this.getControl('main').value.name,
      subName: this.getControl('sub').value == null ? null : this.getControl('sub').value.name,
      clubName: this.matchDetail.home.clubId == this.getControl('clubId').value ? this.matchDetail.home.name : this.matchDetail.away.name
    }
    // this.addmatchEvent.push(MatchEvent);

    const newUsersArray = this.addmatchEvent;
    newUsersArray.push(MatchEvent);
    this.addmatchEvent = [...newUsersArray];
    // }else{

    // }
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

  removeNewEvent(position: number) {
    const newUsersArray = this.addmatchEvent;
    newUsersArray.splice(position, 1);
    this.addmatchEvent = [...newUsersArray];
  }
}






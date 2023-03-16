
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatchDetail } from 'src/app/models/match-detail.model';
import { ChangeDetectorRef, Component, Inject, OnInit } from '@angular/core';
import { AddMatchEvent, MatchEvent } from 'src/app/models/match-event-detail.model';
import { PlayerForEvent } from 'src/app/models/player-for-event.model';
import { MatchService } from 'src/app/flms/match/match.service';
import { map } from 'rxjs/operators';
import { ClubListPlayerResponse } from 'src/app/models/club-list-player-response.model';
import { ClubListPlayer } from 'src/app/models/club-list-player.model';

@Component({
  selector: 'app-pop-up-add-event',
  templateUrl: './pop-up-add-event.component.html',
  styleUrls: ['./pop-up-add-event.component.scss']
})
export class PopUpAddEventComponent implements OnInit {
  displayedColumns: string[] = ['time', 'type', 'team', 'player', 'assist', 'action']
  matchId: number;
  matchDetail: MatchDetail;
  addmatchEvent: AddMatchEvent[];
  type: string = '';
  clubId: number;
  selectedPlayer: ClubListPlayer;
  selectedAssist: ClubListPlayer;
  listPlayer: ClubListPlayer[] = [];
  matchEvent: MatchEvent[] = [];
  time: string;

  constructor(
    public dialogRef: MatDialogRef<PopUpAddEventComponent>,
    public matchService: MatchService,
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

    this.matchService.getMatchEvent(this.matchId).pipe(
      map((res: MatchEvent[]) => this.matchEvent = res)
      ).subscribe();

  }

  onChangeTypeAndTeam() {
    // alert(this.type + this.clubId);
    let tempClubId: number = null;
    if (this.type != null && this.type != undefined
      && this.clubId != null && this.clubId != undefined) {
      if (this.type == 'OwnGoal') {
        if(this.matchDetail.home.clubId == this.clubId) tempClubId = this.matchDetail.away.clubId;
        if(this.matchDetail.away.clubId == this.clubId) tempClubId = this.matchDetail.home.clubId;
      } else {
        tempClubId = this.clubId;
      }

      this.matchService.getPlayerForEvent(tempClubId).pipe(map((res: ClubListPlayerResponse) => {
        this.listPlayer = res.players
      })
      ).subscribe(res => {

      })
    }

  }

  addlistMatchEvent() {
    let eventTime:number =+this.time;
    const eventlist: AddMatchEvent ={
      mainId: this.selectedPlayer.playerId,
      subId: this.selectedAssist.playerId,
      matchId: this.matchId,
      eventType: this.type,
      eventTime: eventTime,
      clubId: this.clubId
    }
    

  }


}



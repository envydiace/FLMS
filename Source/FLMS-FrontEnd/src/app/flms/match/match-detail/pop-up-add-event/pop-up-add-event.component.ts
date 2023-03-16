
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatchDetail } from 'src/app/models/match-detail.model';
import { ChangeDetectorRef, Component, Inject, OnInit } from '@angular/core';
import { AddMatchEvent } from 'src/app/models/match-event-detail.model';
import { PlayerForEvent } from 'src/app/models/player-for-event.model';
import { MatchService } from 'src/app/flms/match/match.service';
import { map } from 'rxjs/operators';

@Component({
  selector: 'app-pop-up-add-event',
  templateUrl: './pop-up-add-event.component.html',
  styleUrls: ['./pop-up-add-event.component.scss']
})
export class PopUpAddEventComponent implements OnInit {
  displayedColumns: string[] = ['time', 'type', 'team', 'player', 'assist', 'action']
  matchId: number;
  matchDetail: MatchDetail;
  matchEvent: AddMatchEvent[];
  type: string = '';
  clubId: number;
  selectedPlayer: PlayerForEvent;
  listPlayer: PlayerForEvent[] = [];

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

  }

  onChangeTypeAndTeam() {
    // alert(this.type + this.clubId);
    if (this.type != null && this.type != undefined 
      && this.clubId != null 
      && this.clubId != undefined) {
      this.matchService.getPlayerForEvent(this.matchId, this.type, this.clubId).pipe(map((res: PlayerForEvent) => {
        this.listPlayer 
      }))


    }

  }

  addlistMatchEvent() {
    // const eventlist: AddMatchEvent ={

    // }
  }


}



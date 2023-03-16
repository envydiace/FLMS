import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { map } from 'rxjs/operators';
import { MatchEvent } from './../../../../models/match-event-detail.model';
import { MatchService} from '../../match.service';
import { MatDialog } from '@angular/material/dialog';
import { PopUpAddEventComponent } from './../pop-up-add-event/pop-up-add-event.component';


@Component({
  selector: 'app-match-event',
  templateUrl: './match-event.component.html',
  styleUrls: ['./match-event.component.scss']
})
export class MatchEventComponent implements OnInit {
  matchId: number;
  matchEvent: MatchEvent[] = [];

  constructor(
    private route: ActivatedRoute,
    private MatchService: MatchService,
    public dialog: MatDialog,
  ) {
    this.route.queryParams.subscribe(params => {
      this.matchId = params['matchId'];
    });
   }

  ngOnInit(): void {
   
    this.MatchService.getMatchEvent(this.matchId).pipe(
      map((res: MatchEvent[]) => this.matchEvent = res)
      ).subscribe();

  }

  openAddEvent(): void{
    const dialogRef = this.dialog.open(PopUpAddEventComponent, {
      width: '85%',
      data: { }
    });

    dialogRef.afterClosed().subscribe(result => {
     
      console.log('The dialog was closed');
    });
  }
 

}

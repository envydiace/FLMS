import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { map } from 'rxjs/operators';
import { MatchEvent } from './../../../../models/match-event-detail.model';
import { MatchService} from '../../match.service';



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

 

}

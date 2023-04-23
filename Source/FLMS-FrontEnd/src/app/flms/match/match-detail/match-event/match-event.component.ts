import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { first, map } from 'rxjs/operators';
import { AddMatchEvent, MatchEvent } from './../../../../models/match-event-detail.model';
import { MatchService } from '../../match.service';
import { PopUpAddEventComponent } from './../pop-up-add-event/pop-up-add-event.component'
import { MatDialog } from '@angular/material/dialog';
import { CommonService } from 'src/app/common/common/common.service';
import { MatchDetail } from 'src/app/models/match-detail.model';
import { AuthService } from 'src/app/auth/auth.service';


@Component({
  selector: 'app-match-event',
  templateUrl: './match-event.component.html',
  styleUrls: ['./match-event.component.scss']
})
export class MatchEventComponent implements OnInit {
  matchId: number;
  matchEvent: MatchEvent[] = [];
  userRole: any;

  @Input() matchDetail: MatchDetail;

  constructor(
    private route: ActivatedRoute,
    private matchService: MatchService,
    public dialog: MatDialog,
    public commonService: CommonService,
    public authen: AuthService,

  ) {
    this.route.queryParams.subscribe(params => {
      this.matchId = params['matchId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
    this.userRole = this.authen.getUserRole();

  }

  initDataSource() {
    this.getMatchEvent(this.matchId);
  }

  getMatchEvent(matchId: number) {
    this.matchService.getMatchEvent(matchId).pipe(
      map((res: MatchEvent[]) => this.matchEvent = res)
    ).subscribe();
  }


  openAddMatchEvent(matchId: number): void {
    const dialogRef = this.dialog.open(PopUpAddEventComponent, {
      width: '90%',
      data: { matchId: matchId, matchDetail: this.matchDetail }
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result != null) this.addlistMatchEvent(result);
     

      this.initDataSource();
      console.log('The dialog was closed');
    });
  }

  public addlistMatchEvent(addmatchEvent: AddMatchEvent[]) {
    this.matchService.addListEvent(addmatchEvent)
      .pipe(first())
      .subscribe({
        next: () => {
          
          this.initDataSource();

        },
        error: error => {
        }
      });
  }

}

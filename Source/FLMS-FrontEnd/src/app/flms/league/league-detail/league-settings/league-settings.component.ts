import { CdkDragDrop, moveItemInArray, transferArrayItem } from '@angular/cdk/drag-drop';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { map } from 'rxjs/operators';
import { ClubListByLeagueResponse } from 'src/app/models/club-list-by-league-response.model';
import { ClubListByLeague } from 'src/app/models/club-list-by-league.model';
import { LeagueService } from '../../league.service';

@Component({
  selector: 'app-league-settings',
  templateUrl: './league-settings.component.html',
  styleUrls: ['./league-settings.component.scss']
})
export class LeagueSettingsComponent implements OnInit {
  listClubByLeague: ClubListByLeague[] = [];
  leagueId: number;

  constructor(
    private route: ActivatedRoute,
    private leagueService: LeagueService,
  ) {
    this.route.queryParams.subscribe(params => {
      this.leagueId = params['leagueId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.findClubByLeague();
  }

  findClubByLeague() {
    this.leagueService.findClubByLeague(this.leagueId + '', '').pipe(
      map((listClubByLeague: ClubListByLeagueResponse) => this.listClubByLeague = listClubByLeague.clubs)
    ).subscribe();
  }

  drop(event: CdkDragDrop<string[]>) {
    if (event.previousContainer === event.container) {
      moveItemInArray(event.container.data, event.previousIndex, event.currentIndex);

    } else {
      if (event.previousContainer.data[event.currentIndex] != undefined) {
        let oldtarget = event.previousContainer.data[event.previousIndex];
        event.previousContainer.data[event.previousIndex] = event.container.data[event.currentIndex];
        event.container.data[event.currentIndex] = oldtarget;
      } else {
        transferArrayItem(event.previousContainer.data,
          event.container.data,
          event.previousIndex,
          event.currentIndex);
      }
    }
  }
}

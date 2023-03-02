import { Component, OnInit } from '@angular/core';

export interface PeriodicElement {
  time: string;
  clubA: string;
  clubB: string;
  group: string;
  action: string;
}

const ELEMENT_DATA: PeriodicElement[] = [
  { time: '2/2/2023', clubA: 'Club s name', clubB: 'Club s name', group: 'A', action: '' },
  { time: '2/2/2023', clubA: 'Club s name', clubB: 'Club s name', group: 'A', action: '' },
  { time: '2/2/2023', clubA: 'Club s name', clubB: 'Club s name', group: 'A', action: '' },
  { time: '2/2/2023', clubA: 'Club s name', clubB: 'Club s name', group: 'A', action: '' },
  { time: '2/2/2023', clubA: 'Club s name', clubB: 'Club s name', group: 'A', action: '' },
  { time: '2/2/2023', clubA: 'Club s name', clubB: 'Club s name', group: 'A', action: '' },

];
@Component({
  selector: 'app-league-schedule',
  templateUrl: './league-schedule.component.html',
  styleUrls: ['./league-schedule.component.scss']
})
export class LeagueScheduleComponent implements OnInit {
  displayedColumns: string[] = ['time', 'clubA', 'clubB', 'group', 'action'];
  dataSource = ELEMENT_DATA;
  constructor() { }

  ngOnInit(): void {
  }

}

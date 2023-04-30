import { Component, OnInit } from '@angular/core';
import { MatDialog, MatDialogRef } from '@angular/material/dialog';
import { LeagueService } from '../league.service';

@Component({
  selector: 'app-pop-up-choose-losing-team',
  templateUrl: './pop-up-choose-losing-team.component.html',
  styleUrls: ['./pop-up-choose-losing-team.component.scss']
})
export class PopUpChooseLosingTeamComponent implements OnInit {

  constructor(
    private leagueService: LeagueService,
    public dialogRe: MatDialog,
    public dialogRef: MatDialogRef<PopUpChooseLosingTeamComponent>,
  ) {

   }

  ngOnInit(): void {
  }
  onNoClick(): void {
    this.dialogRef.close();
  }
}

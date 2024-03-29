import { Component, OnInit, Inject } from '@angular/core';
import { CommonService } from 'src/app/common/common/common.service';
import { LeagueService } from '../../league.service';
import { MAT_DIALOG_DATA, MatDialog, MatDialogRef } from '@angular/material/dialog';
import { Router } from '@angular/router';

@Component({
  selector: 'app-pop-up-confirm-edit-league',
  templateUrl: './pop-up-confirm-edit-league.component.html',
  styleUrls: ['./pop-up-confirm-edit-league.component.scss']
})
export class PopUpConfirmEditLeagueComponent implements OnInit {
  loading = false;
  conStatus = true;
  constructor(
    private commonService: CommonService,
    private leagueService: LeagueService,
    public dialogRe: MatDialog,
    public dialogRef: MatDialogRef<PopUpConfirmEditLeagueComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: {
     
    },
    private router: Router ,
  ) { }


  ngOnInit(): void {
  }


  onNoClick(): void {
    this.dialogRef.close();
  }

  
}

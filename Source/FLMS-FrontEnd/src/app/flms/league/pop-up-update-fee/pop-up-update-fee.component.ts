import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ActivatedRoute } from '@angular/router';
import { leaguePrize } from '../../../models/league-prize.model';

@Component({
  selector: 'app-pop-up-update-fee',
  templateUrl: './pop-up-update-fee.component.html',
  styleUrls: ['./pop-up-update-fee.component.scss']
})
export class PopUpUpdateFeeComponent implements OnInit {
  displayedColumns: string[] = ['expenseName', 'cost', 'action']
  prizeCostTotal: number = 0;

  constructor(
    public dialogRef: MatDialogRef<PopUpUpdateFeeComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      leaguePrize: leaguePrize[];
    }
  ) {
  }

  ngOnInit(): void {

  }

}

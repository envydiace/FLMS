import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ListFees } from 'src/app/models/fee-detail.model';

@Component({
  selector: 'app-pop-up-add-actual',
  templateUrl: './pop-up-add-actual.component.html',
  styleUrls: ['./pop-up-add-actual.component.scss']
})
export class PopUpAddActualComponent implements OnInit {
  displayedColumns: string[] = ['no', 'expenseName', 'cost','type', 'action']
 
  listFees: ListFees[] = [];
  leagueId: number;
  isActual: boolean;

  constructor(
    public dialogRef: MatDialogRef<PopUpAddActualComponent>,

    @Inject(MAT_DIALOG_DATA)
    public data: {
     isActual: number;
     leagueId: number;
    }

  ) { 
    
  }

  ngOnInit(): void {

  }

}

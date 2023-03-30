import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ListFees } from 'src/app/models/fee-detail.model';

@Component({
  selector: 'app-pop-up-add-actual',
  templateUrl: './pop-up-add-actual.component.html',
  styleUrls: ['./pop-up-add-actual.component.scss']
})
export class PopUpAddActualComponent implements OnInit {
  displayedColumns: string[] = ['no', 'expenseName', 'cost', 'type', 'action']

  listFees: ListFees[] = [];
  leagueId: number;
  isActual: boolean;

  expenseName: string;
  feeCost: number;
  type: string;

  constructor(
    public dialogRef: MatDialogRef<PopUpAddActualComponent>,

    @Inject(MAT_DIALOG_DATA)
    public data: {
      isActual: boolean;
      leagueId: number;
      actual: ListFees[];

    }

  ) {

  }
  onNoClick(): void {
    this.dialogRef.close();
  }

  ngOnInit(): void {
    // this.data.actual.forEach(element => {
    //   const feeTemp: ListFees = {
    //     expenseName: element.expenseName,
    //     cost: element.cost,
    //     feeType: element.feeType
    //   }
    //   const newUserArray = this.listFees;
    //   newUserArray.push(feeTemp);
    //   this.listFees = [...newUserArray];

    // });


  }

  addActualFeetoList() {
    const feeTemp: ListFees = {
      expenseName: this.expenseName,
      cost: this.feeCost,
      feeType: this.type
    }

    const newUserArray = this.listFees;
    newUserArray.push(feeTemp);
    this.listFees = [...newUserArray];

  }
  removePlan(position: number) {
    const newActualArray = this.listFees;
    newActualArray.slice(position, 1);
    this.listFees = [...newActualArray];

  }
}

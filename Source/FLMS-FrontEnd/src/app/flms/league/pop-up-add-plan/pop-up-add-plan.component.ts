import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ListFees } from 'src/app/models/fee-detail.model';

@Component({
  selector: 'app-pop-up-add-plan',
  templateUrl: './pop-up-add-plan.component.html',
  styleUrls: ['./pop-up-add-plan.component.scss']
})
export class PopUpAddPlanComponent implements OnInit {
  displayedColumns: string[] = ['no', 'expenseName', 'cost', 'type', 'action']
  isErrorEn = false;
  isErrorC = false;
  isErrorT = false;

  listFees: ListFees[] = [];
  leagueId: number;
  isActual: boolean;

  expenseName: string;
  planCost: number;
  type: string;

  constructor(
    public dialogRef: MatDialogRef<PopUpAddPlanComponent>,

    @Inject(MAT_DIALOG_DATA)
    public data: {
      isActual: boolean;
      leagueId: number;
      plan: ListFees[];
    }
  ) {

  }

  onNoClick(): void {
    this.dialogRef.close();
  }


  ngOnInit(): void {
    // this.listFees = this.data.plan;
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

  addPlanCostToList() {
    if (this.expenseName == null || this.expenseName.trim() == '' || this.planCost == null || this.type == null) {
      if (this.expenseName == null || this.expenseName.trim() == '') { this.isErrorEn = true } else this.isErrorEn = false;
      if (this.planCost == null) { this.isErrorC = true } else this.isErrorC = false;
      if (this.type == null) { this.isErrorT = true } else this.isErrorT = false;
    } else {
      const planTemp: ListFees = {
        expenseName: this.expenseName,
        cost: this.planCost,
        feeType: this.type

      }

      const newPlanArray = this.listFees;
      newPlanArray.push(planTemp);
      this.listFees = [...newPlanArray];
    }

  }

  removePlan(position: number) {
    const newPlanArray = this.listFees;
    newPlanArray.splice(position, 1);
    this.listFees = [...newPlanArray];

  }

}

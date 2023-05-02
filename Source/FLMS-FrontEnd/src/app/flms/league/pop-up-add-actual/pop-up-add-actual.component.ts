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
  isErrorEn = false;
  isErrorC = false;
  isErrorT = false;

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
    const pattern = /^[a-zA-Z1-9]*$/;
    if (this.expenseName == null || this.expenseName === '' ||
      this.expenseName.trim().length === 0 || this.expenseName.trim().length > 50 ||
      !pattern.test(this.expenseName.trim()) ||
      this.feeCost == null || this.type == null) {
      if (this.expenseName == null || this.expenseName === ''
        || this.expenseName.trim().length === 0 || this.expenseName.length > 50
        || !pattern.test(this.expenseName.trim())
      ) {
        this.isErrorEn = true;
      } else {
        if (this.expenseName.trim().length === 0) {
          this.isErrorEn = true;
        }
        else if (this.expenseName.length > 50) {
          this.isErrorEn = true;
        }
        else if (this.expenseName === '') {
          this.isErrorEn = true;
        } else if (this.expenseName == null) {
          this.isErrorEn = true;
        } else if (!pattern.test(this.expenseName.trim())) {
          this.isErrorEn = true;
        }
        else {
          this.isErrorEn = false;
        }
        this.isErrorEn = false;
      }
      if (this.feeCost == null) { this.isErrorC = true } else this.isErrorC = false;
      if (this.type == null) { this.isErrorT = true } else this.isErrorT = false;
    } else {
      this.isErrorEn = false;
      this.isErrorC = false;
      this.isErrorT = false;
      const feeTemp: ListFees = {
        expenseName: this.expenseName,
        cost: this.feeCost,
        feeType: this.type
      }

      const newUserArray = this.listFees;
      newUserArray.push(feeTemp);
      this.listFees = [...newUserArray];
    }

  }
  removeActual(position: number) {
    const newUsersArray = this.listFees;
    newUsersArray.splice(position, 1);
    this.listFees = [...newUsersArray];
  }


}

import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { leaguePrize } from 'src/app/models/league-prize.model';

@Component({
  selector: 'app-pop-up-update-prize',
  templateUrl: './pop-up-update-prize.component.html',
  styleUrls: ['./pop-up-update-prize.component.scss']
})
export class PopUpUpdatePrizeComponent implements OnInit {
  displayedColumns: string[] = ['position', 'expenseName', 'cost', 'action']
  prizeCostTotal: number = 0;
  listLeaguePrize: leaguePrize[] = [];
  prizeName: string;
  prizeCost: number;

  isErrorEn = false;
  isErrorC = false;

  constructor(
    public dialogRef: MatDialogRef<PopUpUpdatePrizeComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      leaguePrize: leaguePrize[];
    }
  ) {
  }

  ngOnInit(): void {
    this.listLeaguePrize = this.data.leaguePrize;
    this.getTotal();
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  getTotal() {
    this.prizeCostTotal = 0;
    this.listLeaguePrize.forEach(element => {
      this.prizeCostTotal += element.cost;
    });
  }

  addPrizeIntoList() {
    if (this.prizeName == null || this.prizeName === '' || this.prizeName.trim().length === 0 || this.prizeName.length > 50
      || this.prizeCost == null) {
      if (this.prizeName == null || this.prizeName === '' || this.prizeName.trim().length === 0) {
        this.isErrorEn = true;
      } else {
        if (this.prizeName === '') {
          this.isErrorEn = true;
        } else if (this.prizeName.trim().length === 0) {
          this.isErrorEn = true;
        } else if (this.prizeName == null) {
          this.isErrorEn = true;
        } else if (this.prizeName.length > 50) {
          this.isErrorEn = true;
        }
        else {
          this.isErrorEn = false;
        }
      }
      if (this.prizeCost == null) {
        this.isErrorC = true;
      } else {
        this.isErrorC = false;
      }
    } else {
      const prizeTemp: leaguePrize = {
        expenseKey: 'Fx',
        expenseName: this.prizeName,
        cost: this.prizeCost
      }

      const newUsersArray = this.listLeaguePrize;
      newUsersArray.push(prizeTemp);
      this.listLeaguePrize = [...newUsersArray];
    }
    this.getTotal();
  }

  removeFee(position: number) {
    const newUsersArray = this.listLeaguePrize;
    newUsersArray.splice(position, 1);
    this.listLeaguePrize = [...newUsersArray];
    this.getTotal();
  }
}

import { ChangeDetectorRef, Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ActivatedRoute } from '@angular/router';
import { leaguePrize } from '../../../models/league-prize.model';

@Component({
  selector: 'app-pop-up-update-fee',
  templateUrl: './pop-up-update-fee.component.html',
  styleUrls: ['./pop-up-update-fee.component.scss']
})
export class PopUpUpdateFeeComponent implements OnInit {
  displayedColumns: string[] = ['position', 'expenseName', 'cost', 'action']
  feeCostTotal: number = 0;
  listLeagueFee: leaguePrize[] = [];
  feeName: string;
  feeCost: number;

  constructor(
    public dialogRef: MatDialogRef<PopUpUpdateFeeComponent>,
    private changeDetectorRefs: ChangeDetectorRef,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      listFee: leaguePrize[];
    }
  ) {
  }

  ngOnInit(): void {
    this.listLeagueFee = this.data.listFee;
    this.getTotal();
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  getTotal() {
    this.feeCostTotal = 0;
    this.listLeagueFee.forEach(element => {
      this.feeCostTotal += element.cost;
    });
  }

  addFeeIntoList() {
    const feeTemp: leaguePrize = {
      expenseKey: 'Ff',
      expenseName: this.feeName,
      cost: this.feeCost
    }

    const newUsersArray = this.listLeagueFee;
    newUsersArray.push(feeTemp);
    this.listLeagueFee = [...newUsersArray];
    this.getTotal();
  }

  removeFee(position: number) {
    const newUsersArray = this.listLeagueFee;
    newUsersArray.splice(position, 1);
    this.listLeagueFee = [...newUsersArray];
    this.getTotal();
  }
}

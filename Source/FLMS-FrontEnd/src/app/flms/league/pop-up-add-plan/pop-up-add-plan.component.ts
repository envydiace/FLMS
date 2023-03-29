import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-pop-up-add-plan',
  templateUrl: './pop-up-add-plan.component.html',
  styleUrls: ['./pop-up-add-plan.component.scss']
})
export class PopUpAddPlanComponent implements OnInit {
  displayedColumns: string[] = ['no', 'expenseName', 'cost','type', 'action']

  constructor() { }

  ngOnInit(): void {
  }

}

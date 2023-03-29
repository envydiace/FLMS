import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-pop-up-add-actual',
  templateUrl: './pop-up-add-actual.component.html',
  styleUrls: ['./pop-up-add-actual.component.scss']
})
export class PopUpAddActualComponent implements OnInit {
  displayedColumns: string[] = ['no', 'expenseName', 'cost','type', 'action']

  constructor(

  ) { 
    
  }

  ngOnInit(): void {

  }

}

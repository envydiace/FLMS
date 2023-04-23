import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-tournament-tree',
  templateUrl: './tournament-tree.component.html',
  styleUrls: ['./tournament-tree.component.scss']
})
export class TournamentTreeComponent implements OnInit {

  @Input() match: any;
  imgSrc: string = './../../../../../../assets/image/default-logo.png';

  constructor() { }

  ngOnInit(): void {
  }

}

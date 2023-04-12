import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-tournament-tree-gv',
  templateUrl: './tournament-tree-gv.component.html',
  styleUrls: ['./tournament-tree-gv.component.scss']
})
export class TournamentTreeGvComponent implements OnInit {

  @Input() match: any;
  imgSrc: string = './../../../../../../assets/image/default-logo.png';

  constructor() { }

  ngOnInit(): void {
  }

}

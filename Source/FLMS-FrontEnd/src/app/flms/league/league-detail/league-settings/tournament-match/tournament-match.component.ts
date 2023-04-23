import { CdkDragDrop, moveItemInArray, transferArrayItem } from '@angular/cdk/drag-drop';
import { Component, Input, OnInit } from '@angular/core';
import { TreeNode } from 'src/app/models/league-tree.model';

@Component({
  selector: 'app-tournament-match',
  templateUrl: './tournament-match.component.html',
  styleUrls: ['./tournament-match.component.scss']
})
export class TournamentMatchComponent implements OnInit {

  @Input() match: any;
  imgSrc: string = './../../../../../../assets/image/default-logo.png';

  constructor() { }

  ngOnInit(): void {
  }

  drop(event: CdkDragDrop<TreeNode[]>) {
    if (event.previousContainer === event.container) {

      //swap nodeId befor change
      let oldNodeId = event.previousContainer.data[event.previousIndex].nodeId;
      event.previousContainer.data[event.previousIndex].nodeId = event.container.data[event.currentIndex].nodeId;
      event.container.data[event.currentIndex].nodeId = oldNodeId;

      moveItemInArray(event.container.data, event.previousIndex, event.currentIndex);

    } else {
      const previousPosition = event.previousContainer.data[event.previousIndex];
      const currentPosition = event.container.data[event.currentIndex];

      if (previousPosition != undefined && currentPosition != undefined && currentPosition.hasChild == false && previousPosition.hasChild == false) {
        //swap nodeId befor change
        let oldNodeId = event.previousContainer.data[event.previousIndex].nodeId;
        event.previousContainer.data[event.previousIndex].nodeId = event.container.data[event.currentIndex].nodeId;
        event.container.data[event.currentIndex].nodeId = oldNodeId;

        let oldtarget = event.previousContainer.data[event.previousIndex];
        event.previousContainer.data[event.previousIndex] = event.container.data[event.currentIndex];
        event.container.data[event.currentIndex] = oldtarget;
      } else {
        // if (event.container.data.length < 2) {


        //   transferArrayItem(event.previousContainer.data,
        //     event.container.data,
        //     event.previousIndex,
        //     event.currentIndex);
        // }

      }


    }
  }
}

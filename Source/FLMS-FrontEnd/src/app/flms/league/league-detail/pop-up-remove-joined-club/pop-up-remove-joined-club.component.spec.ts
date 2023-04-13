import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpRemoveJoinedClubComponent } from './pop-up-remove-joined-club.component';

describe('PopUpRemoveJoinedClubComponent', () => {
  let component: PopUpRemoveJoinedClubComponent;
  let fixture: ComponentFixture<PopUpRemoveJoinedClubComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpRemoveJoinedClubComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpRemoveJoinedClubComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

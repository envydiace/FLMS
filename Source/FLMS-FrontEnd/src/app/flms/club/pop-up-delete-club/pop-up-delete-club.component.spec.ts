import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpDeleteClubComponent } from './pop-up-delete-club.component';

describe('PopUpDeleteClubComponent', () => {
  let component: PopUpDeleteClubComponent;
  let fixture: ComponentFixture<PopUpDeleteClubComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpDeleteClubComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpDeleteClubComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

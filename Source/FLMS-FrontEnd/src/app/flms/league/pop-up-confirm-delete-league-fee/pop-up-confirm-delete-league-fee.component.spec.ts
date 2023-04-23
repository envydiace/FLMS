import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpConfirmDeleteLeagueFeeComponent } from './pop-up-confirm-delete-league-fee.component';

describe('PopUpConfirmDeleteLeagueFeeComponent', () => {
  let component: PopUpConfirmDeleteLeagueFeeComponent;
  let fixture: ComponentFixture<PopUpConfirmDeleteLeagueFeeComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpConfirmDeleteLeagueFeeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpConfirmDeleteLeagueFeeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

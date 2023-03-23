import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { EditLineUpComponent } from './edit-line-up.component';

describe('EditLineUpComponent', () => {
  let component: EditLineUpComponent;
  let fixture: ComponentFixture<EditLineUpComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ EditLineUpComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(EditLineUpComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

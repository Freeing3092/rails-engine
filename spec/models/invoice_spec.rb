require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  before :each do
    @merchants = create_list(:merchant, 2)
    @merch_1_items = create_list(:item, 3, merchant: @merchants.first)
    @merch_2_items = create_list(:item, 2, merchant: @merchants.last)
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @invoice1 = create(:invoice, merchant:@merchants.first, customer: @customer1)
    @invoice2 = create(:invoice, merchant:@merchants.last, customer: @customer2)
    @invoice3 = create(:invoice, merchant:@merchants.last, customer: @customer2)
    @invoice_item1 = create(:invoice_item, item: @merch_1_items.first, invoice: @invoice1)
    @invoice_item2 = create(:invoice_item, item: @merch_2_items.first, invoice: @invoice2)
  end

  describe 'class methods' do
    describe 'destroy_empty_invoices' do
      it 'destroys records without invoice_items' do
        expect(Invoice.count).to eq(3)

        Invoice.destroy_empty_invoices

        expect(Invoice.count).to eq(2)
        expect{Invoice.find(@invoice3.id)}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end

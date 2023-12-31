# frozen_string_literal: true
ActiveAdmin.register_page "CustomerOrders" do
  content title: 'Customer Orders' do
    Customer.joins(orders: :order_items).distinct.each do |customer|
      panel "Orders for Customer #{customer.id} - #{customer.name}" do
        table_for customer.orders do
          column 'Order ID', sortable: 'orders.id' do |order|
            order.id
          end
          column 'Books Ordered' do |order|
            order.order_items.joins(:book).pluck('order_items.quantity', 'books.name').map { |quantity, name| "#{quantity} x #{name}" }.join(', ')
          end
          column 'Hst' do |order|
            number_to_currency(order.hst)
          end
          column 'Pst' do |order|
            number_to_currency(order.pst)
          end
          column 'Gst' do |order|
            number_to_currency(order.gst)
          end
          column 'Order Total' do |order|
            number_to_currency(order.total_amount)
          end
          column 'Order Status' do |order|
            order.status
          end
        end
      end
    end
  end
end

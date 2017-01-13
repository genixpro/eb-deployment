
# On the demo server, we must clear the database regularly
cron 'clear_demo_database' do
  minute '0'
  hour '3'
  user 'root'
  home '/opt/eb/'
  command %W{
    mongo --eval "db.dropDatabase();" electric_brain && service restart ebapi  && service restart ebworker1 && service restart ebworker2
  }.join(' ')
end


import pydot

# Khởi tạo đồ thị
graph = pydot.Dot(graph_type='digraph')

# Thêm node cho bảng Users
users_table = pydot.Node('Users', shape='ellipse', style='filled', fillcolor='lightblue')
graph.add_node(users_table)

# Thêm node cho bảng User_devices
devices_table = pydot.Node('User_devices', shape='ellipse', style='filled', fillcolor='lightblue')
graph.add_node(devices_table)

# Thêm edge từ user_id trên bảng user_devices đến user_id trên bảng users
edge = pydot.Edge('User_devices:user_id', 'Users:user_id', arrowhead='crow', arrowtail='none')
graph.add_edge(edge)

# Vẽ đồ thị và lưu vào file ảnh
graph.write_png('database_relationship.png')

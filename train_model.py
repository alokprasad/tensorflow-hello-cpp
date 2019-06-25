import tensorflow as tf
#a = tf.Variable(4, name = "a")
#b = tf.Variable(5, name = "b")

a = tf.Variable("Hi ", name = "a")
b = tf.Variable("Alok", name = "b")
result = tf.add(a, b, name = "result")
with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    tf.io.write_graph(sess.graph_def, '.', 'model/test_model.pb', as_text = False)
    print(result.eval())
